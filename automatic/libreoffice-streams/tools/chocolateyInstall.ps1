$ErrorActionPreference = 'Stop'

$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
. $toolsDir\helpers.ps1

$packageArgs = @{
  packageName            = 'libreoffice-fresh'
  version                = '26.2.3'
  fileType               = 'msi'
  url                    = 'https://download.documentfoundation.org/libreoffice/stable/26.2.3/win/x86/LibreOffice_26.2.3_Win_x86.msi'
  url64bit               = 'https://download.documentfoundation.org/libreoffice/stable/26.2.3/win/x86_64/LibreOffice_26.2.3_Win_x86-64.msi'
  checksum               = '8d461c7c6c49701e632248cd37d414aff0eca003879f749da6527e934d308d1b'
  checksum64             = '468d1fb3880af3bcddac002e9054155912c70b45d105bfa1c82036f33456133d'
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
