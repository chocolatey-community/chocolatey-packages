$ErrorActionPreference = 'Stop'

$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
. $toolsDir\helpers.ps1

$packageArgs = @{
  packageName            = 'libreoffice-still'
  version                = '7.5.8.2'
  fileType               = 'msi'
  url                    = 'https://download.documentfoundation.org/libreoffice/stable/7.5.8/win/x86/LibreOffice_7.5.8_Win_x86.msi'
  url64bit               = 'https://download.documentfoundation.org/libreoffice/stable/7.5.8/win/x86_64/LibreOffice_7.5.8_Win_x86-64.msi'
  checksum               = 'd274d141ec8e196ce8e21f805d7282830cf42ce83b0535eb1a134aa5d1d285b1'
  checksum64             = '862ad100ef602e1f1c98f7cfbcff1844eb31b700132b59b1d320a9dbd316dd1c'
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
