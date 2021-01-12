# This is the general install script for Mozilla products (Firefox and Thunderbird).
# This file must be identical for all Choco packages for Mozilla products in this repository.

$ErrorActionPreference = 'Stop'

$toolsPath = Split-Path $MyInvocation.MyCommand.Definition
. $toolsPath\helpers.ps1

$packageName  = 'thunderbird'
$softwareName = 'Mozilla Thunderbird'

if (Get-32bitOnlyInstalled -product $softwareName) { Write-Host 'Detected the 32-bit version of Thunderbird on a 64-bit system. This package will continue to install the 32-bit version of Thunderbird unless the 32-bit version is uninstalled.' }

$alreadyInstalled = (AlreadyInstalled -product $softwareName -version '78.6.1')
if ($alreadyInstalled -and ($env:ChocolateyForce -ne $true)) {
  Write-Host "Thunderbird is already installed. No need to download and re-install."
  return
}

$tbProcess = Get-Process thunderbird -ea 0
if ($tbProcess) {
  Write-Host "Stopping running thunderbird process"
  Stop-Process $tbProcess
  $tbProcess = $tbProcess.Path
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
  Url = "https://download.mozilla.org/?product=thunderbird-78.6.1-SSL&os=win&lang=${locale}"

  silentArgs = '-ms'
  validExitCodes = @(0)
}

if (!(Get-32bitOnlyInstalled($softwareName)) -and (Get-OSArchitectureWidth 64)) {
  $packageArgs.Checksum64 = $checksums.Win64
  $packageArgs.ChecksumType64 = 'sha512'
  $packageArgs.Url64 = "https://download.mozilla.org/?product=thunderbird-78.6.1-SSL&os=win64&lang=${locale}"
}

Install-ChocolateyPackage @packageArgs
if ($tbProcess) {
  Write-Host "Restarting thunderbird process"
  Start-Process $tbProcess
}
