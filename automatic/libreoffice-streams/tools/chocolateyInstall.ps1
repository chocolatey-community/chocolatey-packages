$ErrorActionPreference = 'Stop'

$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
. $toolsDir\helpers.ps1

$packageArgs = @{
  packageName            = 'libreoffice-still'
  version                = '7.3.5'
  fileType               = 'msi'
  url                    = 'https://download.documentfoundation.org/libreoffice/stable/7.3.5/win/x86/LibreOffice_7.3.5_Win_x86.msi'
  url64bit               = 'https://download.documentfoundation.org/libreoffice/stable/7.3.5/win/x86_64/LibreOffice_7.3.5_Win_x64.msi'
  checksum               = 'ddff3b9b8097c419304e6ce13811fee50e5de95465673254baafa42a56095a58'
  checksum64             = '1c3bcb18a5584cd6ead89d54c9a7b3a2dc7377ec741909d81842ffb5771d183e'
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
