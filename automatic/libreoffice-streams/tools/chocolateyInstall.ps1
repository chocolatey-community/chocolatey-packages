$ErrorActionPreference = 'Stop'

$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
. $toolsDir\helpers.ps1

$packageArgs = @{
  packageName            = 'libreoffice-still'
  version                = '24.2.7'
  fileType               = 'msi'
  url                    = 'https://download.documentfoundation.org/libreoffice/stable/24.2.7/win/x86/LibreOffice_24.2.7_Win_x86.msi'
  url64bit               = 'https://download.documentfoundation.org/libreoffice/stable/24.2.7/win/x86_64/LibreOffice_24.2.7_Win_x86-64.msi'
  checksum               = '84fb7733da2133194afc1e92ebfcdb6d96e268dca710bdc05e1a55adabc8009b'
  checksum64             = 'cd7cc555ccafcf42d571662fdc29c37c68b49d32d3f8f5b2a113e782145d59e6'
  checksumType           = 'sha256'
  checksumType64         = 'sha256'
  silentArgs             = '/qn /passive /norestart /l*v "{0}"' -f "$($env:TEMP)\$($env:ChocolateyPackageName).$($env:ChocolateyPackageVersion).MsiInstall.log"
  validExitCodes         = @(0,3010)
  softwareName           = 'LibreOffice*'
}

if (-not (IsUrlValid $packageArgs.url)) {
  $exactVersion = GetLibOExactVersion $packageArgs.version
  $packageArgs.url = $exactVersion.Url32
  $packageArgs.url64bit = $exactVersion.Url64
}

Install-ChocolateyPackage @packageArgs
