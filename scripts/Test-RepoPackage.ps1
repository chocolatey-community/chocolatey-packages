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

.PARAMETER artifactsDirectory
  The directory to where the script should save all artifacts (screenshots, logs, etc).
  (The directory does not need to exist before running the script)

.PARAMETER runChocoWithAu
  When specified we uses AU's Test-Package function instead of installing directly
  with choco (NOTE: No validation is done by itself in this case)

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
  [string]$artifactsDirectory = "$env:TEMP\artifacts",
  [switch]$runChocoWithAu
)

function CheckPackageSizes() {
  $nupkgFiles = Get-ChildItem "$PSScriptRoot\.." -Filter "*.nupkg" -Recurse

  $nupkgFiles | % {
    $size = $_.Length
    $maxSize = 150 * 1024 *1024
    $packageName = $_.Directory.Name
    if ($size -gt $maxSize) {
      $friendlySize = $size / 1024 / 1024
      WriteOutput -type Error "The package $packageName is too large. Maximum allowed size is 150 MB. Actual size was $friendlySize MB!"
      SetAppveyorExitCode -ExitCode 2
    } else {
      $index = 0
      $suffix = @('Bytes';'KB';'MB')
      $friendlySize = $size
      while ($friendlySize -ge 1024 -and $index -lt ($suffix.Count - 1)) { $index++; $friendlySize /= 1024 }
      $friendlySize = "{0:N2} {1}" -f $friendlySize,$suffix[$index]
      WriteOutput "The size of the package $packageName was $friendlySize."
    }
  }
}

function CreateSnapshotArchive() {
  param($packages, [string]$artifactsDirectory)

  if (!(Get-Command 7z.exe -ea 0)) { WriteOutput -type Warning "7zip was not found in path, skipping creation of 7zip archive."; return }

  if (!(Test-Path $artifactsDirectory)) { mkdir $artifactsDirectory }
  $directories = $packages | ? {
    Test-path "$env:ChocolateyInstall\.chocolatey\$($_.Name)*"
  } | % {
    $directory = Resolve-Path "$env:ChocolateyInstall\.chocolatey\$($_.Name)*" | select -last 1
    "`"$directory`""
  }

  $arguments = @(
    'a'
    '-mx9'
    "`"$artifactsDirectory\install_snapshot.7z`""
  ) + $directories

  . 7z $arguments
}

function CreateLogArchive() {
  param([string]$artifactsDirectory)

  $arguments = @(
    'a'
    '-mx9'
    "`"$artifactsDirectory\choco_logs.7z`""
    "`"$env:ChocolateyInstall\logs\*`""
  )
  . 7z $arguments
}

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
      '(^|==\>.*\:)\s*ERROR|\s*Failures|^Uninstall may not be silent' { WriteOutput $text -type ChocoError }
      '(^|==\>.*\:)\s*WARNING' { WriteOutput $text -type ChocoWarning }
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
      $root = Resolve-Path "$PSScriptRoot\.." -Relative
      $path = Split-Path -Parent "$root\$_"
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
  if ($arguments[0] -eq 'uninstall') {
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
    if ($arguments[0] -eq 'install') {
      $packageName = $arguments[1] -split ' ' | select -first 1
      $nupkgFile = Get-ChildItem -Path "$PSScriptRoot\.." -Filter "$packageName*.nupkg" -Recurse | select -first 1
      $version = Split-Path -Leaf $nupkgFile | % { ($_ -replace '((\.\d+)+(-[^-\.]+)?).nupkg', ':$1').Replace(':.', ':') -split ':' } | select -last 1
      if ($version) {
        $args += @("--version=$($version)")
        if ($version -match '\-') {
          $args += @('--prerelease')
        }
      }
    }
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

function RunUpdateScripts {
  param(
    $packages
  )
  [array]$manualPackages = $packages | ? { !$_.IsAutomatic -and (Test-Path "$($_.Directory)\update.ps1") }
  # Currently we do not support dependent packages
  if (!$manualPackages) {
    WriteOutput "No manual packages that contain an update script"
    return
  }

  $manualPackages | % {
    $name = $_.Name
    WriteOutput "Running update.ps1 for $name"
    try {
      pushd $_.Directory
      .\update.ps1
    } catch {
      SetAppveyorExitCode 1
      throw "An exception ocurred during the manual update of $name. Cancelling all other checks."
    } finally {
      popd
    }
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
    if ($runChocoWithAu) { Test-Package -Install | WriteChocoOutput }
    else {
      InstallPackage `
        -package $_ `
        -chocoCommandTimeout $chocoCommandTimeout `
        -screenshotTimeout $screenshotTimeout `
        -takeScreenshot $takeScreenshot `
        -screenShotDir $screenShotDir
      MoveLogFile -packageName $_.Name -commandType 'install'
    }
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
      if ($runChocoWithAu) { Test-Package -Uninstall | WriteChocoOutput }
      else {
        UninstallPackage `
          -package $_ `
          -chocoCommandTimeout $chocoCommandTimeout `
          -screenshotTimeout $screenshotTimeout `
          -takeScreenshot $takeScreenshot `
          -screenShotDir $screenShotDir
        MoveLogFile -packageName $name -commandType 'uninstall'
      }
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
    CleanFiles -screenShotDir $artifactsDirectory
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
  screenShotDir = $artifactsDirectory
}

if (@('all','update').Contains($type)) {
  TestAuUpdatePackages -packages $packages
  RunUpdateScripts -packages $packages
}
if (@('all','install').Contains($type)) {
  [array]$failedInstalls = TestInstallAllPackages @arguments
  if (!$runChocoWithAu) { CreateSnapshotArchive -packages $packages -artifactsDirectory $artifactsDirectory }
} else { $failedInstalls = @() }
if (@('all','uninstall').Contains($type)) {
  [array]$failedUninstalls = TestUninstallAllPackages @arguments -failedInstalls $failedInstalls
}
if (@('all','install','uninstall').Contains($type) -and !$runChocoWithAu) { CreateLogArchive $artifactsDirectory }

if ($failedInstalls.Count -gt 0) {
  WriteOutput "The following packages failed to install:" -type ChocoWarning
  WriteOutput "    $($failedInstalls -join ' ')" -type ChocoWarning
}
if ($failedUninstalls.Count -gt 0) {
  WriteOutput "The following packages failed to uninstall:" -type ChocoWarning
  WriteOutput "    $($failedUninstalls -join ' ')" -type ChocoWarning
}

CheckPackageSizes
