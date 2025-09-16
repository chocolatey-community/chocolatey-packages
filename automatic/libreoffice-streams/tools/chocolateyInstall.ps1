$ErrorActionPreference = 'Stop'

$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
. $toolsDir\helpers.ps1

$packageArgs = @{
  packageName            = 'libreoffice-still'
  version                = '25.2.6'
  fileType               = 'msi'
  url                    = 'https://download.documentfoundation.org/libreoffice/stable/25.2.6/win/x86/LibreOffice_25.2.6_Win_x86.msi'
  url64bit               = 'https://download.documentfoundation.org/libreoffice/stable/25.2.6/win/x86_64/LibreOffice_25.2.6_Win_x86-64.msi'
  checksum               = '8060bfe65ee49f892164b5c7db0472e929e781187fa500e4fe932125e9ac1e43'
  checksum64             = '6dc0a82113c01f6f1ac74a91a3f8f6cfcd45b918a67ceed8e36336fc6a6fea82'
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
