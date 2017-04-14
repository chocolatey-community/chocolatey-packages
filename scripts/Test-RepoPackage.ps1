<#
.SYNOPSIS
  Test the au updating of changed packages, as well as the install and uninstall of those packages.

.DESCRIPTION
  This script uses git to get all the packages that have changed since it diverged from the
  master branch and runs those packages through au updating (only if they are automatic packages),
  tries to install them and also tries to uninstall those packages.
  It also accepts an optional packageName that overrides the check for changed packages.

.PARAMETER packageName
  An optional value accepting a single package name.
  If this variable is not specified, or if it's set to $null it gets the package
  name from changed files.

.PARAMETER type
  An optional variable that can be used to specify which kind of tests that should
  be run.
  If the value is set to 'all' (the default) all tests will be run.

.PARAMETER CleanFiles
  If this variable have been specified the script will clean all
  chocolatey logs, au output files and the nupkg files already existing
  in the repository before running the tests.

.PARAMETER TakeScreenshots
  If this variable have been provided, the script will take a screenshot
  of the user desktop after install/uninstall as well as when the message
  'Failures' have been outputted by the choco executable.

.PARAMETER chocoCommandTimeout
  The timeout that should be passed to choco when installing/uninstalling
  packages (defaults to 600 seconds, or 10 minutes)

.PARAMETER timeoutBeforeScreenshot
  The amount of seconds to sleep after installing/uninstalling a package
  and before taking the screenshot.

.PARAMETER screenShotDir
  The directory to where the scrip should save all taken screenshots.
  (The directory does not need to exist before running the script)

.EXAMPLE
  .\Test-RepoPackage.ps1
#>
param(
  [string]$packageName = $null,
  [ValidateSet('all','update','install','uninstall','none')]
  [string]$type = 'all',
  [switch]$CleanFiles,
  [switch]$TakeScreenshots,
  [int]$chocoCommandTimeout = 600,
  [int]$timeoutBeforeScreenshot = 1,
  [string]$screenShotDir = "$env:TEMP\screenshots"
)

function WriteOutput() {
<#
.SYNOPSIS
  Simple helper function to simplify
  the different output methods we use.
#>
  param(
    [Parameter(ValueFromPipeline = $true)]
    [string]$text,
    [ValidateSet('Error','Warning','ChocoError','ChocoWarning','ChocoInfo','Normal')]
    [string]$type = 'Normal'
  )
   switch -Exact ($type) {
    'Error' { Write-Error $text }
    'Warning' { Write-Warning $text }
    'ChocoError' { Write-Host $text -ForegroundColor Black -BackgroundColor Red }
    'ChocoWarning' { Write-Host $text -ForegroundColor Black -BackgroundColor Yellow }
    'ChocoInfo' { Write-Host $text -ForegroundColor White -BackgroundColor Black }
    Default { Write-Host $text }
  }
}

function WriteChocoOutput() {
<#
.SYNOPSIS
  A simple helper function for processing the output of choco.
  Only meant to handle the colorization of text.
#>
  param(
    [Parameter(ValueFromPipeline = $true)]
    [string]$text
  )
  begin {}
  process {
    switch -Regex ($text) {
      '^\s*ERROR|\s*Failures|^Uninstall may not be silent' { WriteOutput $text -type ChocoError }
      '^\s*WARNING' { WriteOutput $text -type ChocoWarning }
      Default { WriteOutput $text -type ChocoInfo }
    }
  }
  end {}
}

function CleanFiles() {
<#
.SYNOPSIS
  The function responsible for cleaning out temporary
  files before we run the tests.
#>
  param(
    [Parameter(Mandatory = $true)]
    [string]$screenShotDir
  )
  $pathsToClean = @(
    "$env:ChocolateyInstall\logs\*"
    "$env:TEMP\chocolatey\au\*"
    "$PSScriptRoot\..\Update-Force-Test*.md"
  )
  if ($TakeScreenshots) { $pathsToClean += @("$screenShotDir\*") }
  $pathsToClean += Get-ChildItem -Recurse "$PSScriptRoot\.." -Filter "*.nupkg" | select -Expand FullName

  $pathsToClean | % {
    if (Test-Path $_) { rm $_ -Recurse }
  }
}

function GetDependentPackage() {
<#
.SYNOPSIS
  Function responsible for aquiring a meta package(s) dependency.
#>
  param(
    [Parameter(Mandatory = $true)]
    [string]$packageDirectory
  )
  $packageName = $PackageDirectory -split '[\/\\]' | select -last 1
  $nuspecPath = Get-Item "$PackageDirectory\*.nuspec"
  $content = Get-Content -Encoding UTF8 $nuspecPath
  $Matches = $null
  $content | ? { $_ -match "\<dependency.*id=`"(${packageName}.(install|portable|app|commandline))" } | select -First 1 | WriteOutput
  $result = if ($Matches) { $Matches[1].ToLowerInvariant() } else { $null }
  return $result
}

function GetPackagePath() {
<#
.SYNOPSIS
  Gets the full path to the specified package.
#>
  param([string]$packageName)
  if ($packageName -eq $null -or $packageName -eq '') {
    return $null
  }
  $sourcePath = gci "$PSScriptRoot\.." -Recurse -Filter "$packageName.nuspec" | select -First 1 -Expand Directory
  if (!$sourcePath) {
    WriteOutput "No path was found for the package: $packageName" -type Warning
  }
  return $sourcePath
}

function GetPackageSelectQuery() {
  param(
    [Parameter(Mandatory = $true, ValueFromPipeline = $true)]
    $InputObject
  )
  begin { $queries = @() }
  process {
    $queries += $InputObject | select `
      @{Name = 'NuspecPath'; Expression = {Resolve-Path "$_\*.nuspec"}},
      @{Name = 'Directory'; Expression = {Resolve-Path $_}},
      @{Name = 'Name'; Expression = {[System.IO.Path]::GetFileName($_).ToLowerInvariant()}},
      @{Name = 'IsAutomatic'; Expression = {$_ -match 'automatic[\/\\]'}},
      @{Name = 'DependentPackage'; Expression = {GetDependentPackage -packageDirectory $_}}
  }
  end {
    $queries
   }
}

function GetPackagesFromDiff() {
<#
  Gets the changed packages that have changed since the
  latest common ancestor of the current branch, and the specified $diffAgainst branch.

.PARAMETER diffAgainst
  The branch we should run git diff against.
#>
  param(
    [Parameter(Mandatory = $true)]
    [ValidateNotNull()]
    [string]$diffAgainst
  )
  $paths = git diff "${diffAgainst}..." --name-only | % {
    if ($_.StartsWith('..')) {
      $path = Split-Path -Parent $_
    } else {
      $path = Split-Path -Parent (Resolve-Path -Relative "$PSScriptRoot\..\$_")
    }
    while ($path -and !(Test-Path "$path\*.nuspec")) {
      $path = Split-Path -Parent $path
    }
    if ($path) { $path }
  } | select -Unique

  return $paths | GetPackageSelectQuery
}

function GetPackagesFromName() {
  param(
    [Parameter(Mandatory = $true)]
    [ValidateNotNullOrEmpty()]
    [string]$packageName
  )
  return Get-ChildItem "$PSScriptRoot\..\" -Recurse -Filter "$packageName.nuspec" | select -Unique -expand Directory | GetPackageSelectQuery
}

function MoveLogFile() {
<#
.SYNOPSIS
  Renames the chocolatey.log file to a file matching the specified packageName and commandType
  so it only contains the necessary log for the current package.
#>
  param(
    [Parameter(Mandatory = $true)]
    [string]$packageName,
    [Parameter(Mandatory = $true)]
    [string]$commandType
  )

  if (Test-Path "$env:ChocolateyInstall\logs\chocolatey.log") {
    mv "$env:ChocolateyInstall\logs\chocolatey.log" "$env:ChocolateyInstall\logs\${commandType}_${packageName}.log" | WriteOutput
  }
}

function RemoveDependentPackages() {
  param(
    [object]$packages
  )

  [array]$dependentPackages = $packages | ? { $_.DependentPackage -ne $null -and $_.DependentPackage -ne '' } | select -expand DependentPackage
  if ($dependentPackages -ne $null -and $dependentPackages.Count -gt 0) {
    $packages = $packages | ? { !$dependentPackages.Contains($_.Name) }
  }
  return $packages
}

function RunChocoPackProcess() {
<#
.SYNOPSIS
  Function responsible for running choco pack when a nupkg file have not already been created.
#>
  param([string]$path)
  if ($path -ne $null -and $path -ne '') { pushd $path }
  if (!(Test-Path "*.nupkg")) {
    . choco pack | WriteChocoOutput
    if ($LastExitCode -ne 0) { popd; throw "Choco pack failed with code: $LastExitCode"; return }
  }
  if ($path -ne $null -and $path -ne '') { popd}
}

function SetAppveyorExitCode() {
<#
.SYNOPSIS
  Sets the exit code of the script when running on appveyor, so
  the build would fail when necessary.
#>
  param(
    [int]$ExitCode
  )
  WriteOutput "Exit code was $ExitCode" -type Warning

  if (!(Test-Path env:\APPVEYOR)) {
    return
  }
  if ($ExitCode -ne 0) {
    $host.SetShouldExit($ExitCode)
  }
}

function UploadAppveyorArtifact() {
<#
.SYNOPSIS
  Uploads the specified filePaths to appveyor when a appveyor build
  is currently running.
#>
  param(
    [string[]]$filePaths
  )

  if (Test-Path env:\APPVEYOR) {
    $filePaths | ? { Test-Path $_ } | % { Push-AppveyorArtifact $_ -FileName (Split-Path -Leaf $_)}
  }
}

function RunChocoProcess() {
<#
  Function responsible for running choco install/uninstall
  and handling choco failures.
#>
  param(
    [Parameter(Mandatory = $true)]
    [string[]]$arguments,
    [Parameter(Mandatory = $true)]
    [int]$timeout,
    [Parameter(Mandatory = $true)]
    [bool]$takeScreenshot,
    [Parameter(Mandatory = $true)]
    [int]$timeoutBeforeScreenshot,
    [Parameter(Mandatory = $true)]
    [string]$screenShotDir
  )

  $res = $true
  $args = @($arguments) + @(
    '--yes'
    "--execution-timeout=$timeout"
  )
  if ($arguments[0] -eq 'install') {
    $args += @(
      '--requirechecksum'
    )
  } else {
    $args += @(
      '--all-versions'
      '--autouninstaller'
      '--fail-on-autouninstaller'
    )
  }
  $packFailed = $false
  $errorFilePath = "$screenShotDir\$($arguments[0])Error_$($arguments[1]).jpg"
  if (!(Test-Path "$screenShotDir")) { mkdir "$screenShotDir" -Force | Out-Null }

  try {
    RunChocoPackProcess '' | WriteChocoOutput
    $failureOccurred = $false
    $previousPercentage = -1;
    $progressRegex = 'Progress\:.*\s+([\d]+)\%'
    . choco $args | % {
      $matches = $null
      if ($failureOccurred) { WriteOutput $_ -type ChocoError }
       # We are only showing progress per 10th value
      elseif([regex]::IsMatch($_, $progressRegex)) {
        $progressMatch = [regex]::Match($_, $progressRegex).Groups[1].Value
        if (($progressMatch % 10) -eq 0) {
          if ($progressMatch -ne $previousPercentage) {
            WriteChocoOutput $_
          }
          $previousPercentage = $progressMatch
        }
      }
      else { WriteChocoOutput $_ }

      if ($_ -match "Failures") {
        $failureOccurred = $true
        $res = $false
        # Allow everything to complete before we continue
        sleep -Seconds 5
        if ($takeScreenshot) {
          Take-ScreenShot -file $errorFilePath -imagetype jpeg
          # Wait for a second so the screenshot can be taken before we continue
          sleep -Seconds 1
        }
        if ($arguments[0] -eq 'uninstall') {
          Stop-Process -ProcessName "unins*" -ErrorAction Ignore
        }

        Stop-Process -ProcessName "*$($arguments[1])*" -ErrorAction Ignore
      }
    }
  } finally {
    if ($LastExitCode -ne 0) {
      SetAppveyorExitCode $LastExitCode
      $res = $false
    }
    if ($takeScreenshot -and !$packFailed) {
      if ($timeoutBeforeScreenshot -gt 0) { sleep -Seconds $timeoutBeforeScreenshot }
      WriteOutput "Taking screenshot after $($arguments[0])"
      # We take a screenshot when install/uninstall have finished to see if a program have started that isn't monitored by choco
      $filePath = "$screenShotDir\$($arguments[0])_$($arguments[1]).jpg"
      Take-ScreenShot -file $filePath -imagetype jpeg
      UploadAppveyorArtifact $errorFilePath,$filePath
    }
  }
  return $res
}

function InstallPackage() {
<#
.SYNOPSIS
  Function responsible for testing the installation of a single package.
#>
  param(
    [Parameter(Mandatory = $true)]
    $package,
    [Parameter(Mandatory = $true)]
    [int]$chocoCommandTimeout,
    [Parameter(Mandatory = $true)]
    [int]$screenshotTimeout,
    [Parameter(Mandatory = $true)]
    [bool]$takeScreenshot,
    [Parameter(Mandatory = $true)]
    [string]$screenShotDir
  )

  $dependentSource = GetPackagePath -packageName $package.DependentPackage
  if ($dependentSource) {
    try {
      RunChocoPackProcess -path $dependentSource | WriteChocoOutput
    } catch {
      WriteOutput $_ -type Error
      return $package.Name
    }
    $sources = "$($_.Directory);$dependentSource;chocolatey"
  } else {
    $sources = "$($_.Directory);chocolatey"
  }

  $arguments = @{
    timeout = $chocoCommandTimeout
    takeScreenshot = $takeScreenshot
    timeoutBeforeScreenshot = $screenshotTimeout
    arguments = 'install',$package.Name,"--source=`"$sources`""
    screenShotDir = $screenShotDir
  }

  try {
  if (!(RunChocoProcess @arguments)) { return $package.Name }
  } catch {
    WriteOutput $_ -type Error
    return $package.Name
  }

  return ""
}

function TestAuUpdatePackages() {
<#
.SYNOPSIS
  Function responsible for running au on the specified packages.
#>
  param(
    $packages
  )
  [array]$packageNames = $packages | ? IsAutomatic | select -expand Name
  $packageNames += $packages | ? { $_.DependentPackage -ne $null -and $_.DependentPackage -ne '' } | select -expand DependentPackage
  if (!$packageNames) {
    WriteOutput "No Automatic packages was found. Skipping AU update test."
    return
  }

  try {
    pushd "$PSScriptRoot\.."
    .\test_all.ps1 -Name $packageNames -ThrowOnErrors
  } catch {
    SetAppveyorExitCode $LastExitCode
    throw "An exception ocurred during AU update. Cancelling all other checks."
  } finally {
    MoveLogFile -packageName 'au' -commandType 'update'
    popd
  }
}

function TestInstallAllPackages() {
<#
.SYNOPSIS
  Function responsible for running the install tests on the specified packages.
#>
  param(
    [Parameter(Mandatory = $true)]
    $packages,
    [Parameter(Mandatory = $true)]
    [int]$chocoCommandTimeout,
    [Parameter(Mandatory = $true)]
    [int]$screenshotTimeout,
    [Parameter(Mandatory = $true)]
    [bool]$takeScreenshot,
    [Parameter(Mandatory = $true)]
    [string]$screenShotDir,
    [Parameter(ValueFromRemainingArguments = $true)]
    [object[]]$ignoredValues
  )

  $packages | % {
    pushd $_.Directory
    InstallPackage `
      -package $_ `
      -chocoCommandTimeout $chocoCommandTimeout `
      -screenshotTimeout $screenshotTimeout `
      -takeScreenshot $takeScreenshot `
      -screenShotDir $screenShotDir
    MoveLogFile -packageName $_.Name -commandType 'install'
    popd
  } | ? { $_ -ne $null -and $_ -ne '' }
}

function UninstallPackage() {
<#
.SYNOPSIS
  Function responsible for testing the uninstallation of a single package.
#>
  param(
    [Parameter(Mandatory = $true)]
    $package,
    [Parameter(Mandatory = $true)]
    [int]$chocoCommandTimeout,
    [Parameter(Mandatory = $true)]
    [int]$screenshotTimeout,
    [Parameter(Mandatory = $true)]
    [bool]$takeScreenshot,
    [Parameter(Mandatory = $true)]
    [string]$screenShotDir
  )

  $dependentSource = GetPackagePath -packageName $package.DependentPackage
  if ($dependentSource) {
    try {
      RunChocoPackProcess -path $dependentSource | WriteOutput
    } catch {
      WriteOutput $_ -type Error
      return $package.Name
    }
    $packageNames = @($package.Name ; $package.DependentPackage)
  } else {
    $packageNames = @($package.Name)
  }

  $arguments = @{
    timeout = $chocoCommandTimeout
    takeScreenshot = $takeScreenshot
    timeoutBeforeScreenshot = $screenshotTimeout
    arguments = @('uninstall';$packageNames)
    screenShotDir = $screenShotDir
  }
  try {
    if (!(RunChocoProcess @arguments)) { return $package.Name }
  } catch {
    WriteOutput $_ -type Error
    return $package.Name
  }

  return ""
}

function TestUninstallAllPackages() {
<#
.SYNOPSIS
  Function responsible for running the uninstall tests on the specified packages.
  But only if the package names isn't listed in the specified failedInstall object array.
#>
  param(
    [Parameter(Mandatory = $true)]
    $packages,
    [Parameter(Mandatory = $true)]
    [int]$chocoCommandTimeout,
    [Parameter(Mandatory = $true)]
    [int]$screenshotTimeout,
    [Parameter(Mandatory = $true)]
    [bool]$takeScreenshot,
    [Parameter(Mandatory = $true)]
    [string]$screenShotDir,
    [object[]]$failedInstalls,
    [Parameter(ValueFromRemainingArguments = $true)]
    [object[]]$ignoredValues
  )

  $packages | % {
    $name = $_.Name
    $packageFailed = $failedInstalls | ? { $_ -eq $name }
    if ($packageFailed) {
      WriteOutput "$name failed to install, skipping uninstall test..." -type Warning
      return ""
    } else {
      pushd $_.Directory
      UninstallPackage `
        -package $_ `
        -chocoCommandTimeout $chocoCommandTimeout `
        -screenshotTimeout $screenshotTimeout `
        -takeScreenshot $takeScreenshot `
        -screenShotDir $screenShotDir
      MoveLogFile -packageName $name -commandType 'uninstall'
      popd
    }
  } | ? { $_ -ne $null -and $_ -ne '' }
}

if ($packageName) {
  $packages = GetPackagesFromName -packageName $packageName
} else {
  $packages = GetPackagesFromDiff -diffAgainst 'origin/master'
}

$packages = RemoveDependentPackages -packages $packages

if ($CleanFiles) {
    CleanFiles -screenShotDir $screenShotDir
}

if (!$packages) {
  WriteOutput "No changed packages was found. Exiting tests..." -type Warning
  return;
}

if ($TakeScreenshots) { . "$PSScriptRoot\Take-ScreenShot.ps1" }
$arguments = @{
  packages = $packages
  chocoCommandTimeout = $chocoCommandTimeout
  takeScreenshot = $TakeScreenshots
  screenShotTimeout = $timeoutBeforeScreenshot
  screenShotDir = $screenShotDir
}

switch -Exact ($type) {
  'update' {
    TestAuUpdatePackages -packages $packages
  }
  'install' {
    [array]$failedInstalls = TestInstallAllPackages @arguments
  }
  'uninstall' {
    [array]$failedUninstalls = TestUninstallAllPackages @arguments
   }
   'none' { WriteOutput "No tests is being run." }
  Default {
    TestAuUpdatePackages -packages $packages
    [array]$failedInstalls = TestInstallAllPackages @arguments
    [array]$failedUninstalls = TestUninstallAllPackages @arguments -failedInstalls $failedInstalls
  }
}

if ($failedInstalls.Count -gt 0) {
  WriteOutput "The following packages failed to install:" -type ChocoWarning
  WriteOutput "    $($failedInstalls -join ' ')" -type ChocoWarning
}
if ($failedUninstalls.Count -gt 0) {
  WriteOutput "The following packages failed to uninstall:" -type ChocoWarning
  WriteOutput "    $($failedUninstalls -join ' ')" -type ChocoWarning
}
