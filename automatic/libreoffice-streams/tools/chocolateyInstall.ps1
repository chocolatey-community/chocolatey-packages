$ErrorActionPreference = 'Stop'

$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
. $toolsDir\helpers.ps1

$packageArgs = @{
  packageName            = 'libreoffice-still'
  version                = '7.4.5'
  fileType               = 'msi'
  url                    = 'https://download.documentfoundation.org/libreoffice/stable/7.4.5/win/x86/LibreOffice_7.4.5_Win_x86.msi'
  url64bit               = 'https://download.documentfoundation.org/libreoffice/stable/7.4.5/win/x86_64/LibreOffice_7.4.5_Win_x64.msi'
  checksum               = '0e3fa8d7d4aa090e9708f27099f0e0a1f2edde88735e00fad6a1c3b864ca7aa1'
  checksum64             = 'aacdb6ec15cf1b76287cd089582e8d76fe769b218c1dbcbc7496cda5c3cd662b'
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
