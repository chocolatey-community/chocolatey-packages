$ErrorActionPreference = 'Stop'
# This is the general install script for Mozilla products (Firefox and Thunderbird).
# This file must be identical for all Choco packages for Mozilla products in this repository.
$toolsPath = Split-Path $MyInvocation.MyCommand.Definition
. $toolsPath\helpers.ps1

$packageName = 'thunderbird'
$softwareName = 'Mozilla Thunderbird'

$alreadyInstalled = (AlreadyInstalled -product $softwareName -version '52.5.2')

if ($alreadyInstalled -and ($env:ChocolateyForce -ne $true)) {
  Write-Output $(
    "Thunderbird is already installed. " +
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
    Url = "https://download-installer.cdn.mozilla.net/pub/thunderbird/releases/52.5.2/win32/${locale}/Thunderbird%20Setup%2052.5.2.exe"

    silentArgs = '-ms'
    validExitCodes = @(0)
  }

  Install-ChocolateyPackage @packageArgs
}
