$ErrorActionPreference = 'Stop'

$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
. $toolsDir\helpers.ps1

$packageArgs = @{
  packageName            = 'libreoffice-still'
  version                = '7.0.4'
  fileType               = 'msi'
  url                    = 'https://download.documentfoundation.org/libreoffice/stable/7.0.4/win/x86/LibreOffice_7.0.4_Win_x86.msi'
  url64bit               = 'https://download.documentfoundation.org/libreoffice/stable/7.0.4/win/x86_64/LibreOffice_7.0.4_Win_x64.msi'
  checksum               = 'a19084d17b2170e08319651846c73fff9f103f5e69aa35f8d06f34c55f2cde32'
  checksum64             = '37a36b570a599b9c1e377b7c709155dd566a5eb1e8e857ca139b824d3a12e55b'
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
