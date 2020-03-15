$ErrorActionPreference = 'Stop'

$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
. $toolsDir\helpers.ps1

$packageArgs = @{
  packageName            = 'libreoffice-still'
  version                = '6.3.5'
  fileType               = 'msi'
  url                    = 'https://download.documentfoundation.org/libreoffice/stable/6.3.5/win/x86/LibreOffice_6.3.5_Win_x86.msi'
  url64bit               = 'https://download.documentfoundation.org/libreoffice/stable/6.3.5/win/x86_64/LibreOffice_6.3.5_Win_x64.msi'
  checksum               = '20b6f70dfb6b1ae164dbbb3abc3a07914c5f04fb558e692038acbaddd9fcd3df'
  checksum64             = '9f34a3b4a3e4ccd88f6911f637f8f799fa6bbb623dddb794b926cec85b8c9478'
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
