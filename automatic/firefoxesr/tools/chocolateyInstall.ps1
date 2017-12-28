$ErrorActionPreference = 'Stop'
# This is the general install script for Mozilla products (Firefox and Thunderbird).
# This file must be identical for all Choco packages for Mozilla products in this repository.
$toolsPath = Split-Path $MyInvocation.MyCommand.Definition
. $toolsPath\helpers.ps1

$packageName = 'FirefoxESR'
$softwareName = 'Mozilla Firefox*ESR'

$alreadyInstalled = (AlreadyInstalled -product $softwareName -version '52.5.3')

if (Get-32bitOnlyInstalled -product $softwareName) {
  Write-Output $(
    'Detected the 32-bit version of Firefox on a 64-bit system. ' +
    'This package will continue to install the 32-bit version of Firefox ' +
    'unless the 32-bit version is uninstalled.'
  )
}

if ($alreadyInstalled -and ($env:ChocolateyForce -ne $true)) {
  Write-Output $(
    "Firefox is already installed. " +
    'No need to download an re-install again.'
  )
} else {
  $locale = GetLocale -localeFile "$toolsPath\LanguageChecksums.csv" -product $softwareName
  $checksums = GetChecksums -language $locale -checksumFile "$toolsPath\LanguageChecksums.csv"

  $packageArgs = @{
    packageName = $packageName
    fileType = 'exe'
    softwareName = "$softwareName*"

    Checksum = $checksums.Win32
    ChecksumType = 'sha512'
    Url = "https://download-installer.cdn.mozilla.net/pub/firefox/releases/52.5.3esr/win32/${locale}/Firefox%20Setup%2052.5.3esr.exe"

    silentArgs = '-ms'
    validExitCodes = @(0)
  }

  if (!(Get-32bitOnlyInstalled($softwareName)) -and (Get-ProcessorBits 64)) {
    $packageArgs.Checksum64 = $checksums.Win64
    $packageArgs.ChecksumType64 = 'sha512'
    $packageArgs.Url64 = "https://download-installer.cdn.mozilla.net/pub/firefox/releases/52.5.3esr/win64/${locale}/Firefox%20Setup%2052.5.3esr.exe"
  }

  Install-ChocolateyPackage @packageArgs
}
