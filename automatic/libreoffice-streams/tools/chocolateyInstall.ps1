$ErrorActionPreference = 'Stop'

$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
. $toolsDir\helpers.ps1

$packageArgs = @{
  packageName            = 'libreoffice-still'
  version                = '7.4.6'
  fileType               = 'msi'
  url                    = 'https://download.documentfoundation.org/libreoffice/stable/7.4.6/win/x86/LibreOffice_7.4.6_Win_x86.msi'
  url64bit               = 'https://download.documentfoundation.org/libreoffice/stable/7.4.6/win/x86_64/LibreOffice_7.4.6_Win_x64.msi'
  checksum               = '4f4eec66cd8d9af67fa2d536de0d88569cc4b4e85be75f71f05ce56c819ea767'
  checksum64             = '870a0c2a550c03754ae7974ccc277806a772488e4fd51ea5e146580f8141dae8'
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
