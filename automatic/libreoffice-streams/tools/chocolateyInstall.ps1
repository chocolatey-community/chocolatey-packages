$ErrorActionPreference = 'Stop'

$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
. $toolsDir\helpers.ps1

$packageArgs = @{
  packageName            = 'libreoffice-still'
  version                = '24.2.5'
  fileType               = 'msi'
  url                    = 'https://download.documentfoundation.org/libreoffice/stable/24.2.5/win/x86/LibreOffice_24.2.5_Win_x86.msi'
  url64bit               = 'https://download.documentfoundation.org/libreoffice/stable/24.2.5/win/x86_64/LibreOffice_24.2.5_Win_x86-64.msi'
  checksum               = 'd09952f2841f424e1722a53837ca64393d30f2c86fcb2a015d97a14de5311c3f'
  checksum64             = 'cad625d119db4720df5270fa2d860e0ed56d6e374b878e19a3cab4af68f1f54f'
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
