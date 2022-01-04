$ErrorActionPreference = 'Stop'

$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
. $toolsDir\helpers.ps1

$packageArgs = @{
  packageName            = 'libreoffice-still'
  version                = '7.1.8'
  fileType               = 'msi'
  url                    = 'https://download.documentfoundation.org/libreoffice/stable/7.1.8/win/x86/LibreOffice_7.1.8_Win_x86.msi'
  url64bit               = 'https://download.documentfoundation.org/libreoffice/stable/7.1.8/win/x86_64/LibreOffice_7.1.8_Win_x64.msi'
  checksum               = '1a7fd97895d7070b84110fb5f156fdc05c599c01a5c683cf56a94d00fedc68a3'
  checksum64             = '79e5427c8b02777717c0c714ebbc37c6ca5e9a267e4de6d0d3962b78297e92f5'
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
