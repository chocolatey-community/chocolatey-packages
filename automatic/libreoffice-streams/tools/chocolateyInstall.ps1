$ErrorActionPreference = 'Stop'

$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
. $toolsDir\helpers.ps1

$packageArgs = @{
  packageName            = 'libreoffice-still'
  version                = '24.2.6'
  fileType               = 'msi'
  url                    = 'https://download.documentfoundation.org/libreoffice/stable/24.2.6/win/x86/LibreOffice_24.2.6_Win_x86.msi'
  url64bit               = 'https://download.documentfoundation.org/libreoffice/stable/24.2.6/win/x86_64/LibreOffice_24.2.6_Win_x86-64.msi'
  checksum               = 'f0ba2c0484db0ded3b965c3726ffa2c3d1b1caf1a543d7049457ced880447574'
  checksum64             = 'deeaa615a3a49ff965df345e807623df28baf5d36146f4867e41ea0bc056d60a'
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
