$ErrorActionPreference = 'Stop'

$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
. $toolsDir\helpers.ps1

$packageArgs = @{
  packageName            = 'libreoffice-still'
  version                = '7.0.6'
  fileType               = 'msi'
  url                    = 'https://download.documentfoundation.org/libreoffice/stable/7.0.6/win/x86/LibreOffice_7.0.6_Win_x86.msi'
  url64bit               = 'https://download.documentfoundation.org/libreoffice/stable/7.0.6/win/x86_64/LibreOffice_7.0.6_Win_x64.msi'
  checksum               = '6f71c18af67e5fdfd14eef94dc0271a98f469b147138732a4d2334845042b22e'
  checksum64             = 'a0a82c2a0d659600d3491ad017cb358fe57f078c020cb184cf420934c9e53f99'
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
