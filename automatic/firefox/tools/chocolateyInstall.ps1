$ErrorActionPreference = 'Stop'
# This is the general install script for Mozilla products (Firefox and Thunderbird).
# This file must be identical for all Choco packages for Mozilla products in this repository.
$toolsPath = Split-Path $MyInvocation.MyCommand.Definition
. $toolsPath\helpers.ps1

$packageName = 'Firefox'
$softwareName = 'Mozilla Firefox'

$pp = Get-PackageParameters

$alreadyInstalled = (AlreadyInstalled -product $softwareName -version '75.0')

if (Get-32bitOnlyInstalled -product $softwareName) {
  Write-Output $(
    'Detected the 32-bit version of Firefox on a 64-bit system. ' +
    'This package will continue to install the 32-bit version of Firefox ' +
    'unless the 32-bit version is uninstalled.'
  )
}

$sa = ""

# Command Line Options from the Firefox installer
# https://firefox-source-docs.mozilla.org/browser/installer/windows/installer/FullConfig.html

# Always prevent Firefox installer to require a reboot
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

if ($alreadyInstalled -and $env:ChocolateyForce) {
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
    Url            = "https://download.mozilla.org/?product=firefox-75.0-ssl&os=win&lang=${locale}"
    silentArgs     = "$sa /S"
    validExitCodes = @(0)
  }

  if (!(Get-32bitOnlyInstalled($softwareName)) -and (Get-OSArchitectureWidth 64)) {
    $packageArgs.Checksum64 = $checksums.Win64
    $packageArgs.ChecksumType64 = 'sha512'
    $packageArgs.Url64 = "https://download.mozilla.org/?product=firefox-75.0-ssl&os=win64&lang=${locale}"
  }

  Install-ChocolateyPackage @packageArgs
}

if ($pp.InstallDir) {
  $installPath = $pp.InstallDir
}
else {
  $installPath = Get-AppInstallLocation $softwareName
}

if (-Not(Test-Path ($installPath + "\distribution\policies.json") -ErrorAction SilentlyContinue) -and ($pp.NoAutoUpdate) ) {
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
