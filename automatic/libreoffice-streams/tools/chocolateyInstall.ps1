$ErrorActionPreference = 'Stop'

$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
. $toolsDir\helpers.ps1

$packageArgs = @{
  packageName            = 'libreoffice-fresh'
  version                = '7.2.5'
  fileType               = 'msi'
  url                    = 'https://download.documentfoundation.org/libreoffice/stable/7.2.5/win/x86/LibreOffice_7.2.5_Win_x86.msi'
  url64bit               = 'https://download.documentfoundation.org/libreoffice/stable/7.2.5/win/x86_64/LibreOffice_7.2.5_Win_x64.msi'
  checksum               = '34d3514e33ea1f9acb029219381c1446d7d29a95d6c81ad0fae95035ec62c04f'
  checksum64             = 'dfbf02fd97515e06e55c53d5dc0108fb680f92146b093cd4ba9c43e87fdd0dc5'
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
