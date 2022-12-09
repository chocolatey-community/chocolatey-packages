$ErrorActionPreference = 'Stop'

$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
. $toolsDir\helpers.ps1

$packageArgs = @{
  packageName            = 'libreoffice-fresh'
  version                = '7.4.3'
  fileType               = 'msi'
  url                    = 'https://download.documentfoundation.org/libreoffice/stable/7.4.3/win/x86/LibreOffice_7.4.3_Win_x86.msi'
  url64bit               = 'https://download.documentfoundation.org/libreoffice/stable/7.4.3/win/x86_64/LibreOffice_7.4.3_Win_x64.msi'
  checksum               = '07415d8740079623f5d21eddcdf10212935ddd43d52e0f54b06d52cc43c44bcd'
  checksum64             = 'f4cf0fe2ff0b9716d3622202c4dcbd7aedabce03e135a159d747f9bbeb92da01'
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
