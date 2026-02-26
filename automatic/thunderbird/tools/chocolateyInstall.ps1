# This is the general install script for Mozilla products (Firefox and Thunderbird).
# This file must be identical for all Choco packages for Mozilla products in this repository.

$ErrorActionPreference = 'Stop'

$toolsPath = Split-Path $MyInvocation.MyCommand.Definition
. $toolsPath\helpers.ps1

$packageName  = 'thunderbird'
$softwareName = 'Mozilla Thunderbird'

$pp = Get-PackageParameters

if (Get-32bitOnlyInstalled -product $softwareName) { Write-Host 'Detected the 32-bit version of Thunderbird on a 64-bit system. This package will continue to install the 32-bit version of Thunderbird unless the 32-bit version is uninstalled.' }

$sa = ""

# Command Line Options from the Thunderbird (and Firefox) installer
# https://firefox-source-docs.mozilla.org/browser/installer/windows/installer/FullConfig.html

# Always prevent Thunderbird installer to require a reboot
$sa += " /PreventRebootRequired=true"

# Prevent RemoveDistributionDir by default
$sa += " /RemoveDistributionDir=false"


$sa += if ($pp.InstallDir) { " /InstallDirectoryPath=" + $pp.InstallDir }

$sa += if ($pp.NoTaskbarShortcut) { " /TaskbarShortcut=false" }

$sa += if ($pp.NoDesktopShortcut) { " /DesktopShortcut=false" }

$sa += if ($pp.NoStartMenuShortcut) { " /StartMenuShortcut=false" }

$sa += if ($pp.NoMaintenanceService) { " /MaintenanceService=false" }

$sa += if ($pp.RemoveDistributionDir) { " /RemoveDistributionDir=true" }

$sa += if ($pp.NoAutoUpdate) { " /MaintenanceService=false" }

$alreadyInstalled = (AlreadyInstalled -product $softwareName -version '148.0')
if ($alreadyInstalled -and ($env:ChocolateyForce -ne $true)) {
  Write-Host "Thunderbird is already installed. No need to download and re-install."
  return
}

$tbProcess = Get-Process thunderbird -ea 0
if ($tbProcess) {
  if ($pp.NoStop) {
    Write-Warning "Not stopping running thunderbird process"  
  } else {
    Write-Host 'Stopping running thunderbird process'
    Stop-Process $tbProcess
    # We make an assumption that the first unique item found
    # will be have the path to the process we want to restart.
    $tbProcess = $tbProcess.Path | Select-Object -Unique -First 1
  }
}

$locale = 'en-US' #https://github.com/chocolatey/chocolatey-coreteampackages/issues/933
$locale = GetLocale -localeFile "$toolsPath\LanguageChecksums.csv" -product $softwareName
$checksums = GetChecksums -language $locale -checksumFile "$toolsPath\LanguageChecksums.csv"

$packageArgs = @{
  packageName = $packageName
  fileType = 'exe'
  softwareName = "$softwareName*"

  Checksum = $checksums.Win32
  ChecksumType = 'sha512'
  Url = "https://download.mozilla.org/?product=thunderbird-148.0&os=win&lang=${locale}"

  silentArgs     = "$sa /S"
  validExitCodes = @(0)
}

if (!(Get-32bitOnlyInstalled($softwareName)) -and (Get-OSArchitectureWidth 64)) {
  $packageArgs.Checksum64 = $checksums.Win64
  $packageArgs.ChecksumType64 = 'sha512'
  $packageArgs.Url64 = "https://download.mozilla.org/?product=thunderbird-148.0&os=win64&lang=${locale}"
}

Install-ChocolateyPackage @packageArgs

if ($pp.InstallDir) {
  $installPath = $pp.InstallDir
}
else {
  $installPath = Get-AppInstallLocation $softwareName
}

if (-Not(Test-Path ($installPath + "\distribution\policies.json") -ErrorAction SilentlyContinue) -and ($pp.NoAutoUpdate) ) {
  if (-Not(Test-Path ($installPath + "\distribution") -ErrorAction SilentlyContinue)) {
    New-Item ($installPath + "\distribution") -ItemType directory
  }

  $policies = @"
{
    "policies":  {
                     "DisableAppUpdate":  true
                 }
}
"@

  $policies | Out-File -FilePath ($installPath + "\distribution\policies.json") -Encoding ascii
}

if ($tbProcess -and !$pp.NoStop) {
  Write-Host "Restarting thunderbird process"
  Start-Process $tbProcess
}
