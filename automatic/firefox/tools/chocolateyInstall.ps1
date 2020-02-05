$ErrorActionPreference = 'Stop'
# This is the general install script for Mozilla products (Firefox and Thunderbird).
# This file must be identical for all Choco packages for Mozilla products in this repository.
$toolsPath = Split-Path $MyInvocation.MyCommand.Definition
. $toolsPath\helpers.ps1

$packageName = 'Firefox'
$softwareName = 'Mozilla Firefox'

$PackageParameters = Get-PackageParameters

$alreadyInstalled = (AlreadyInstalled -product $softwareName -version '72.0.1')

if (Get-32bitOnlyInstalled -product $softwareName) {
  Write-Output $(
    'Detected the 32-bit version of Firefox on a 64-bit system. ' +
    'This package will continue to install the 32-bit version of Firefox ' +
    'unless the 32-bit version is uninstalled.'
  )
}

$args = ""

# Command Line Options from the Firefox Installer
# https://firefox-source-docs.mozilla.org/browser/installer/windows/installer/FullConfig.html

if ($PackageParameters['InstallDirectoryPath']) {
  $args = $args + " /InstallDirectoryPath=" + $PackageParameters['InstallDirectoryPath']
}

if ($PackageParameters['InstallDirectoryName']) {
  $args = $args + " /InstallDirectoryName=" + $PackageParameters['InstallDirectoryName']
}

if ($PackageParameters['TaskbarShortcut']) {
  $args = $args + " /TaskbarShortcut=" + $PackageParameters['TaskbarShortcut']
}

if ($PackageParameters['DesktopShortcut']) {
  $args = $args + " /DesktopShortcut=" + $PackageParameters['DesktopShortcut']
}

if ($PackageParameters['StartMenuShortcut']) {
  $args = $args + " /StartMenuShortcut=" + $PackageParameters['StartMenuShortcut']
}

if ($PackageParameters['MaintenanceService']) {
  $args = $args + " /MaintenanceService=" + $PackageParameters['MaintenanceService']
}

if ($PackageParameters['RemoveDistributionDir']) {
  $args = $args + " /RemoveDistributionDir=" + $PackageParameters['RemoveDistributionDir']
}

if ($PackageParameters['PreventRebootRequired']) {
  $args = $args + " /PreventRebootRequired=" + $PackageParameters['PreventRebootRequired']
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
    Url            = "https://download.mozilla.org/?product=firefox-72.0.1-ssl&os=win&lang=${locale}"

    silentArgs     = "$($args) -ms"
    validExitCodes = @(0)
  }

  if (!(Get-32bitOnlyInstalled($softwareName)) -and (Get-OSArchitectureWidth 64)) {
    $packageArgs.Checksum64 = $checksums.Win64
    $packageArgs.ChecksumType64 = 'sha512'
    $packageArgs.Url64 = "https://download.mozilla.org/?product=firefox-72.0.1-ssl&os=win64&lang=${locale}"
  }

  Install-ChocolateyPackage @packageArgs
}
