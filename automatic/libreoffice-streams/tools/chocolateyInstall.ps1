$ErrorActionPreference = 'Stop'

$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
. $toolsDir\helpers.ps1

$packageArgs = @{
  packageName            = 'libreoffice-still'
  version                = '24.8.5'
  fileType               = 'msi'
  url                    = 'https://download.documentfoundation.org/libreoffice/stable/24.8.5/win/x86/LibreOffice_24.8.5_Win_x86.msi'
  url64bit               = 'https://download.documentfoundation.org/libreoffice/stable/24.8.5/win/x86_64/LibreOffice_24.8.5_Win_x86-64.msi'
  checksum               = 'c4f81d04db578b5d587d4cf49995161419a9defe7765e62644c84a38a9685543'
  checksum64             = 'ef3077c919fb05a5778818a00b7f9b329841691e6892bfb664d117e83ea27c9c'
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
