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
  [ValidateSet('all', 'update', 'install', 'uninstall', 'none')]
  [string]$type = 'all',
  [switch]$CleanFiles,
  [switch]$TakeScreenshots,
  [int]$chocoCommandTimeout = 600,
  [int]$timeoutBeforeScreenshot = 1,
  [string]$artifactsDirectory = "$env:TEMP\artifacts",
  [switch]$runChocoWithAu
)

function CheckPackageSizes() {
  $nupkgFiles = Get-ChildItem "$PSScriptRoot\.." -Filter '*.nupkg' -Recurse

  foreach ($file in $nupkgFiles) {
    $size = $file.Length
    $maxSize = 200MB
    $pkgName = $file.Directory.Name

    if ($size -gt $maxSize) {
      $friendlySize = [math]::Round($size / 1MB, 2)
      WriteOutput -Type Error "The package $pkgName is too large. Maximum allowed size is 200 MB. Actual size was $friendlySize MB!"
      SetAppveyorExitCode -ExitCode 2
    }
    else {
      $friendly = switch ($size) {
        { $_ -lt 1KB } { '{0:N0} Bytes' -f $_ }
        { $_ -lt 1MB } { '{0:N2} KB' -f ($_ / 1KB) }
        Default { '{0:N2} MB' -f ($_ / 1MB) }
      }
      WriteOutput "The size of the package $pkgName was $friendly."
    }
  }
}

function CreateSnapshotArchive {
  param($packages, [string]$artifactsDirectory)

  if (-not (Get-Command 7z.exe -ErrorAction SilentlyContinue)) {
    WriteOutput -Type Warning '7zip was not found in PATH, skipping snapshot archive'
    return
  }

  if (-not (Test-Path $artifactsDirectory)) {
    New-Item $artifactsDirectory -ItemType Directory | Out-Null
  }

  $dirs = $packages |
  ForEach-Object {
    $candidate = "$env:ChocolateyInstall\.chocolatey\$($_.Name)*"
    if (Test-Path $candidate) {
              (Resolve-Path $candidate | Select-Object -Last 1).ToString()
    }
  } |
  Sort-Object -Unique

  if ($dirs.Count -eq 0) { return }
  & 7z a -mx9 "`"$artifactsDirectory\install_snapshot.7z`"" $dirs
}

function CreateLogArchive() {
  param([string]$artifactsDirectory)

  & 7z a -mx9 "`"$artifactsDirectory\choco_logs.7z`"" "`"$env:ChocolateyInstall\logs\*`""
}

function WriteOutput() {
  <#
.SYNOPSIS
  Simple helper function to simplify
  the different output methods we use.
#>
  [CmdletBinding()]
  param(
    [Parameter(ValueFromPipeline)]
    [string]$Text,
    [ValidateSet('Error', 'Warning', 'ChocoError', 'ChocoWarning', 'ChocoInfo', 'Normal')]
    [string]$Type = 'Normal'
  )
  process {
    switch ($Type) {
      'Error' { Write-Error        $Text }
      'Warning' { Write-Warning      $Text }
      'ChocoError' { Write-Output  $Text }
      'ChocoWarning' { Write-Output  $Text }
      'ChocoInfo' { Write-Output  $Text }
      Default { Write-Output  $Text }
    }
  }
}

function WriteChocoOutput() {
  <#
.SYNOPSIS
  A simple helper function for processing the output of choco.
  Only meant to handle the colorization of text.
#>
  [CmdletBinding()]
  param(
    [Parameter(ValueFromPipeline)]
    [string]$Text
  )
  begin {}
  process {
    switch -Regex ($Text) {
      '(^|==\>.*\:)\s*ERROR|\s*Failures|^Uninstall may not be silent' { WriteOutput $Text -Type ChocoError }
      '(^|==\>.*\:)\s*WARNING' { WriteOutput $Text -Type ChocoWarning }
      Default { WriteOutput $Text -Type ChocoInfo }
    }
  }
}

function CleanFiles() {
  <#
.SYNOPSIS
  The function responsible for cleaning out temporary
  files before we run the tests.
#>
  param([string]$screenShotDir)

  $paths = @(
    "$env:ChocolateyInstall\logs\*",
    "$env:TEMP\chocolatey\au\*",
    "$PSScriptRoot\..\Update-Force-Test*.md"
  )
  if ($TakeScreenshots) { $paths += "$screenShotDir\*" }
  $paths += (Get-ChildItem -Recurse "$PSScriptRoot\.." -Filter '*.nupkg').FullName

  foreach ($p in $paths) { if (Test-Path $p) { Remove-Item $p -Recurse -Force } }
}

function GetDependentPackage() {
  <#
.SYNOPSIS
  Function responsible for aquiring a meta package(s) dependency.
#>
  param([string]$packageDirectory)

  $packageName = Split-Path $packageDirectory -Leaf
  $nuspec = Get-Item "$packageDirectory\*.nuspec"
  $regex = [regex]"<dependency.*id=`"(${packageName}\.(install|portable|app|commandline))"

  $line = Get-Content -Encoding UTF8 $nuspec | Where-Object { $regex.IsMatch($_) } | Select-Object -First 1
  if ($null -ne $line) {
    return $regex.Match($line).Groups[1].Value.ToLowerInvariant()
  }
  return $null
}

function GetPackagePath() {
  <#
.SYNOPSIS
  Gets the full path to the specified package.
#>
  param([string]$packageName)
  if ([string]::IsNullOrWhiteSpace($packageName)) { return $null }

  $src = Get-ChildItem "$PSScriptRoot\.." -Recurse -Filter "$packageName.nuspec" |
  Select-Object -First 1 -ExpandProperty Directory
  if (-not $src) { WriteOutput -Type Warning "No path was found for the package: $packageName" }
  return $src
}

function Get-InternalDependency() {
  <#
        .SYNOPSIS
            Return **all** repository-internal dependencies of a nuspec,
            walking the graph recursively (breadth-first, unique).
    #>
  param(
    [Parameter(Mandatory)]
    [string]$NuspecPath,

    [hashtable]$Seen = @{}
  )

  $xml = [xml](Get-Content $NuspecPath -Encoding UTF8)
  $repoRoot = Resolve-Path "$PSScriptRoot\.."     # script lives in scripts/

  foreach ($dep in $xml.package.metadata.dependencies.dependency) {
    $id = $dep.id
    if ($Seen.ContainsKey($id)) { continue }

    $dir = Get-ChildItem $repoRoot -Directory -Filter $id -Recurse | Select-Object -First 1
    if ($dir) {
      $Seen[$id] = $true
      Get-InternalDependency "$($dir.FullName)\$id.nuspec" -Seen $Seen | Out-Null
    }
  }
  return $Seen.Keys
}

function GetPackageSelectQuery() {
  param([Parameter(ValueFromPipeline)]$InputObject)
  begin { $list = @() }
  process {
    $nuspecPath = Resolve-Path "$InputObject\*.nuspec"
    $list += [pscustomobject]@{
      NuspecPath           = $nuspecPath
      Directory            = Resolve-Path $InputObject
      Name                 = [IO.Path]::GetFileName($InputObject).ToLowerInvariant()
      IsAutomatic          = $InputObject -match 'automatic[\/\\]'
      DependentPackage     = GetDependentPackage -packageDirectory $_
      InternalDependencies = Get-InternalDependency -NuspecPath $nuspecPath
    }
  }
  end { $list }
}

function GetPackagesFromDiff() {
  <#
  Gets the changed packages that have changed since the
  latest common ancestor of the current branch, and the specified $diffAgainst branch.

.PARAMETER diffAgainst
  The branch we should run git diff against.
#>
  param([string]$diffAgainst)

  $paths = (git diff "${diffAgainst}..." --name-only | ForEach-Object {
      $path = if ($_.StartsWith('..')) { Split-Path -Parent $_ } else {
        $root = Resolve-Path "$PSScriptRoot\.." -Relative
        Split-Path -Parent "$root\$_"
      }
      while ($path -and -not (Test-Path "$path\*.nuspec")) { $path = Split-Path -Parent $path }
      if ($path) { $path }
    }
  ) | Sort-Object -Unique

  $paths | GetPackageSelectQuery
}

function GetPackagesFromName() {
  param([string]$packageName)

  Get-ChildItem "$PSScriptRoot\.." -Recurse -Filter "$packageName.nuspec" |
  Select-Object -Unique -ExpandProperty Directory |
  GetPackageSelectQuery
}

function MoveLogFile() {
  <#
.SYNOPSIS
  Renames the chocolatey.log file to a file matching the specified packageName and commandType
  so it only contains the necessary log for the current package.
#>
  param([string]$packageName, [string]$commandType)

  if (Test-Path "$env:ChocolateyInstall\logs\chocolatey.log") {
    Move-Item "$env:ChocolateyInstall\logs\chocolatey.log" `
      "$env:ChocolateyInstall\logs\${commandType}_${packageName}.log"
  }
}

function RemoveDependentPackages() {
  param($packages)

  $dependent = $packages |
  Where-Object { $_.DependentPackage } |
  Select-Object -ExpandProperty DependentPackage
  if ($null -ne $dependent -and $dependent.Count -gt 0) {
    $packages = $packages | Where-Object { $dependent -notcontains $_.Name }
  }
  return $packages
}

function RunChocoPackProcess() {
  <#
.SYNOPSIS
  Function responsible for running choco pack when a nupkg file have not already been created.
#>
  param([string]$Path)

  if (-not $Path) {
    # nothing to push – just run choco
    if (-not (Test-Path '*.nupkg')) {
      choco pack | WriteChocoOutput
      if ($LASTEXITCODE) { throw "Choco pack failed with code $LASTEXITCODE" }
    }
    return
  }

  Push-Location $Path
  try {
    if (-not (Test-Path '*.nupkg')) {
      choco pack | WriteChocoOutput
      if ($LASTEXITCODE) { throw "Choco pack failed with code $LASTEXITCODE" }
    }
  }
  finally {
    Pop-Location
  }
}

function SetAppveyorExitCode() {
  <#
.SYNOPSIS
  Sets the exit code of the script when running on appveyor, so
  the build would fail when necessary.
#>
  param([int]$ExitCode)

  WriteOutput -Type Warning "Exit code was $ExitCode"
  if (Test-Path env:\APPVEYOR -and $ExitCode) { $Host.SetShouldExit($ExitCode) }
}

function RunChocoProcess() {
  <#
  Function responsible for running choco install/uninstall
  and handling choco failures.
#>
  param(
    [string[]]$Arguments,
    [int]     $Timeout,
    [bool]    $TakeScreenshot,
    [int]     $TimeoutBeforeScreenshot,
    [string]  $ScreenShotDir
  )

  $result = $true
  $chocoArgs = @($Arguments) + @('--yes', "--execution-timeout=$Timeout", '--ignorepackagecodes')

  if ($Arguments[0] -eq 'uninstall') {
    $chocoArgs += '--all-versions', '--autouninstaller', '--fail-on-autouninstaller'
  }

  if (-not (Test-Path $ScreenShotDir)) { New-Item $ScreenShotDir -ItemType Directory | Out-Null }

  $pkgName = ($Arguments[1] -split ' ')[0]
  $pkgDir = Get-ChildItem "$PSScriptRoot\.." -Filter $pkgName -Recurse -Directory | Select-Object -First 1
  $nupkg = Get-ChildItem $pkgDir.FullName -Filter '*.nupkg' | Select-Object -First 1
  $parts = (Split-Path -Leaf $nupkg) -replace '((\.\d+)+(-[^-\.]+)?).nupkg', ':$1' -replace ':\.', ':' -split ':'
  $version = $parts[-1]

  if ($pkgName -ne $Arguments[1]) { $chocoArgs[1] = $pkgName }

  try {
    RunChocoPackProcess ''

    if ($Arguments[0] -eq 'install' -and $version) {
      $chocoArgs += "--version=$version"
      if ($version -match '-') { $chocoArgs += '--prerelease' }
    }

    $failure = $false
    $prevPercent = -1
    $progressRx = [regex]'Progress\:.*\s+(\d+)\%'

    choco $chocoArgs | ForEach-Object {
      if ($failure) { WriteOutput $_ -Type ChocoError; return }

      if ($progressRx.IsMatch($_)) {
        $pct = [int]$progressRx.Match($_).Groups[1].Value
        if (($pct % 10) -eq 0 -and $pct -ne $prevPercent) {
          WriteChocoOutput $_
          $prevPercent = $pct
        }
      }
      else {
        WriteChocoOutput $_
      }

      if ($_ -match 'Failures') {
        $failure = $true
        $result = $false
        Start-Sleep 5
        if ($TakeScreenshot) {
          Take-ScreenShot -file "$ScreenShotDir\$($Arguments[0])Error_$pkgName.jpg" -imagetype jpeg
          Start-Sleep 1
        }
        if ($Arguments[0] -eq 'uninstall') { Stop-Process -ProcessName 'unins*' -ErrorAction Ignore }
        Stop-Process -ProcessName "*$pkgName*" -ErrorAction Ignore
      }
    }
  }
  finally {
    if ($LASTEXITCODE) { SetAppveyorExitCode $LASTEXITCODE; $result = $false }

    if ($TakeScreenshot) {
      if ($TimeoutBeforeScreenshot -gt 0) { Start-Sleep -Seconds $TimeoutBeforeScreenshot }
      WriteOutput "Taking screenshot after $($Arguments[0])"
      Take-ScreenShot -file "$ScreenShotDir\$($Arguments[0])_$pkgName.jpg" -imagetype jpeg
    }
  }
  return $result
}

function InstallPackage() {
  <#
.SYNOPSIS
  Function responsible for testing the installation of a single package.
#>
  param(
    $package,
    [int]$chocoCommandTimeout,
    [int]$screenshotTimeout,
    [bool]$takeScreenshot,
    [string]$screenShotDir
  )

  $depDirs = foreach ($depId in $package.InternalDependencies) {
    $dir = GetPackagePath -packageName $depId
    if ($dir) { RunChocoPackProcess -Path $dir; $dir }
  }

  $sources = @($package.Directory) + $depDirs + 'chocolatey' | Sort-Object -Unique -Descending
  $srcList = $sources -join ';'

  $chocoArgs = @{
    Timeout                 = $chocoCommandTimeout
    TakeScreenshot          = $takeScreenshot
    TimeoutBeforeScreenshot = $screenshotTimeout
    Arguments               = @('install', $package.Name, "--source=`"$srcList`"")
    ScreenShotDir           = $screenShotDir
  }

  try {
    if (-not (RunChocoProcess @chocoArgs)) { return $package.Name }
  }
  catch {
    WriteOutput $_ -Type Error
    return $package.Name
  }
  return ''
}

function TestAuUpdatePackages() {
  <#
.SYNOPSIS
  Function responsible for running au on the specified packages.
#>
  param($packages)

  $auto = $packages | Where-Object IsAutomatic | Select-Object -ExpandProperty Name
  $meta = $packages | Where-Object { $_.DependentPackage } | Select-Object -ExpandProperty DependentPackage
  $names = $auto + $meta

  if (-not $names) { WriteOutput 'No automatic packages found – skipping AU test.'; return }

  try {
    Push-Location "$PSScriptRoot\.."
    .\test_all.ps1 -Name $names -ThrowOnErrors
  }
  catch {
    SetAppveyorExitCode $LASTEXITCODE
    throw 'Exception during Chocolatey-AU update – aborting.'
  }
  finally {
    MoveLogFile -packageName 'chocolatey-au' -commandType 'update'
    Pop-Location
  }
}

function RunUpdateScripts() {
  param($packages)

  $manual = $packages | Where-Object { -not $_.IsAutomatic -and (Test-Path "$($_.Directory)\update.ps1") }
  if (-not $manual) { WriteOutput 'No manual packages with update.ps1 found'; return }

  foreach ($p in $manual) {
    WriteOutput "Running update.ps1 for $($p.Name)"
    try { Push-Location $p.Directory; .\update.ps1 }
    catch { SetAppveyorExitCode 1; throw "Manual update for $($p.Name) failed – aborting." }
    finally { Pop-Location }
  }
}

function TestInstallAllPackages() {
  <#
.SYNOPSIS
  Function responsible for running the install tests on the specified packages.
#>
  param(
    $packages,
    [int]$chocoCommandTimeout,
    [int]$screenshotTimeout,
    [bool]$takeScreenshot,
    [string]$screenShotDir,
    [object[]]$ignoredValues
  )

  $null = $ignoredValues   # mark as used

  foreach ($p in $packages) {
    Push-Location $p.Directory
    try {
      if ($runChocoWithAu) {
        Test-Package -Install | WriteChocoOutput
      }
      else {
        InstallPackage `
          -package $p `
          -chocoCommandTimeout $chocoCommandTimeout `
          -screenshotTimeout $screenshotTimeout `
          -takeScreenshot $takeScreenshot `
          -screenShotDir $screenShotDir |
        ForEach-Object { $_ }                      # emit result
        MoveLogFile -packageName $p.Name -commandType 'install'
      }
    }
    finally { Pop-Location }
  }
}

function UninstallPackage() {
  <#
.SYNOPSIS
  Function responsible for testing the uninstallation of a single package.
#>
  param(
    $package,
    [int]$chocoCommandTimeout,
    [int]$screenshotTimeout,
    [bool]$takeScreenshot,
    [string]$screenShotDir
  )

  $names = @($package.InternalDependencies + $package.Name) | Select-Object -Unique
  [array]::Reverse($names)

  $chocoArgs = @{
    Timeout                 = $chocoCommandTimeout
    TakeScreenshot          = $takeScreenshot
    TimeoutBeforeScreenshot = $screenshotTimeout
    Arguments               = @('uninstall') + $names
    ScreenShotDir           = $screenShotDir
  }

  try {
    if (-not (RunChocoProcess @chocoArgs)) { return $package.Name }
  }
  catch {
    WriteOutput $_ -Type Error
    return $package.Name
  }
  return ''
}

function TestUninstallAllPackages() {
  <#
.SYNOPSIS
  Function responsible for running the uninstall tests on the specified packages.
  But only if the package names isn't listed in the specified failedInstall object array.
#>
  param(
    $packages,
    [int]$chocoCommandTimeout,
    [int]$screenshotTimeout,
    [bool]$takeScreenshot,
    [string]$screenShotDir,
    [object[]]$failedInstalls,
    [object[]]$ignoredValues
  )

  $null = $ignoredValues   # mark as used

  foreach ($p in $packages) {
    if ($failedInstalls -contains $p.Name) {
      WriteOutput "$($p.Name) failed to install, skipping uninstall…" -Type Warning
      continue
    }

    Push-Location $p.Directory
    try {
      if ($runChocoWithAu) {
        Test-Package -Uninstall | WriteChocoOutput
      }
      else {
        UninstallPackage `
          -package $p `
          -chocoCommandTimeout $chocoCommandTimeout `
          -screenshotTimeout $screenshotTimeout `
          -takeScreenshot $takeScreenshot `
          -screenShotDir $screenShotDir |
        ForEach-Object { $_ }                      # emit result
        MoveLogFile -packageName $p.Name -commandType 'uninstall'
      }
    }
    finally { Pop-Location }
  }
}

$packages = if ($packageName) {
  GetPackagesFromName -packageName $packageName
}
else {
  GetPackagesFromDiff -diffAgainst 'origin/master'
}

$packages = RemoveDependentPackages -packages $packages

if ($CleanFiles) { CleanFiles -screenShotDir $artifactsDirectory }

if (-not $packages) { WriteOutput 'No changed packages detected – exiting.' -Type Warning; return }

if ($TakeScreenshots) { . "$PSScriptRoot\Take-ScreenShot.ps1" }

$commonArgs = @{
  packages            = $packages
  chocoCommandTimeout = $chocoCommandTimeout
  takeScreenshot      = $TakeScreenshots
  screenshotTimeout   = $timeoutBeforeScreenshot
  screenShotDir       = $artifactsDirectory
}

if ('all', 'update' -contains $type) { TestAuUpdatePackages @commonArgs; RunUpdateScripts -packages $packages }
if ('all', 'install' -contains $type) {
  $failedInstalls = TestInstallAllPackages @commonArgs
  if (-not $runChocoWithAu) { CreateSnapshotArchive -packages $packages -artifactsDirectory $artifactsDirectory }
}
else { $failedInstalls = @() }
if ('all', 'uninstall' -contains $type) {
  $failedUninstalls = TestUninstallAllPackages @commonArgs -failedInstalls $failedInstalls
}
if (('all', 'install', 'uninstall') -contains $type -and -not $runChocoWithAu) { CreateLogArchive $artifactsDirectory }

if ($failedInstalls) { WriteOutput "Packages failed to install:`n    $($failedInstalls -join ' ')"   -Type ChocoWarning }
if ($failedUninstalls) { WriteOutput "Packages failed to uninstall:`n    $($failedUninstalls -join ' ')" -Type ChocoWarning }

CheckPackageSizes
