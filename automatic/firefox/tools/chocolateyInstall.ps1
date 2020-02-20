$ErrorActionPreference = 'Stop'
# This is the general install script for Mozilla products (Firefox and Thunderbird).
# This file must be identical for all Choco packages for Mozilla products in this repository.
$toolsPath = Split-Path $MyInvocation.MyCommand.Definition
. $toolsPath\helpers.ps1

$packageName = 'Firefox'
$softwareName = 'Mozilla Firefox'

$PackageParameters = Get-PackageParameters

$alreadyInstalled = (AlreadyInstalled -product $softwareName -version '73.0.1')

if (Get-32bitOnlyInstalled -product $softwareName) {
  Write-Output $(
    'Detected the 32-bit version of Firefox on a 64-bit system. ' +
    'This package will continue to install the 32-bit version of Firefox ' +
    'unless the 32-bit version is uninstalled.'
  )
}

$args = ""

# Command Line Options from the Firefox installer
# https://firefox-source-docs.mozilla.org/browser/installer/windows/installer/FullConfig.html

# Always prevent Firefox installer to require a reboot
$args = $args + " /PreventRebootRequired=true"

# Prevent RemoveDistributionDir by default
$args = $args + " /RemoveDistributionDir=false"


if ($PackageParameters['InstallDir']) {
  $args = $args + " /InstallDirectoryPath=" + $PackageParameters['InstallDir']
}

if ($PackageParameters.NoTaskbarShortcut) {
  $args = $args + " /TaskbarShortcut=false"
}

if ($PackageParameters.NoDesktopShortcut) {
  $args = $args + " /DesktopShortcut=false"
}

if ($PackageParameters.NoStartMenuShortcut) {
  $args = $args + " /StartMenuShortcut=false"
}

if ($PackageParameters.NoMaintenanceService) {
  $args = $args + " /MaintenanceService=false"
}

if ($PackageParameters.RemoveDistributionDir) {
  $args = $args + " /RemoveDistributionDir=true"
}

if ($PackageParameters.NoAutoUpdate) {
  $args = $args + " /MaintenanceService=false"
}

if ($alreadyInstalled -and ($env:ChocolateyForce -ne $true)) {
  Write-Output $(
    "Firefox is already installed. " +
    'No need to download and re-install.'
  )
}
else {
  $locale = 'en-US' #https://github.com/chocolatey/chocolatey-coreteampackages/issues/933
  $locale = GetLocale -localeFile "$toolsPath\LanguageChecksums.csv" -product $softwareName
  $checksums = GetChecksums -language $locale -checksumFile "$toolsPath\LanguageChecksums.csv"

  $packageArgs = @{
    packageName    = $packageName
    fileType       = 'exe'
    softwareName   = "$softwareName*"
    Checksum       = $checksums.Win32
    ChecksumType   = 'sha512'
    Url            = "https://download.mozilla.org/?product=firefox-73.0.1-ssl&os=win&lang=${locale}"
    silentArgs     = "$($args) /S"
    validExitCodes = @(0)
  }

  if (!(Get-32bitOnlyInstalled($softwareName)) -and (Get-OSArchitectureWidth 64)) {
    $packageArgs.Checksum64 = $checksums.Win64
    $packageArgs.ChecksumType64 = 'sha512'
    $packageArgs.Url64 = "https://download.mozilla.org/?product=firefox-73.0.1-ssl&os=win64&lang=${locale}"
  }

  Install-ChocolateyPackage @packageArgs
}

if ($PackageParameters['InstallDir']) {
  $installPath = $PackageParameters['InstallDir']
}
else {
  $installPath = "C:\Program Files\Mozilla Firefox"
}

if (-Not(Test-Path ($installPath + "\distribution\policies.json") -ErrorAction SilentlyContinue) -and ($PackageParameters.NoAutoUpdate) ) {
  if (-Not(Test-Path ($installPath + "\distribution") -ErrorAction SilentlyContinue)) {
    new-item ($installPath + "\distribution") -itemtype directory
  }

  $policies = @{
    policies = @{
      "DisableAppUpdate" = $true
    }
  }
  $policies | ConvertTo-Json | Out-File -FilePath ($installPath + "\distribution\policies.json") -Encoding ascii

}
