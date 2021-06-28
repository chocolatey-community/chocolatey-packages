$ErrorActionPreference = 'Stop'

$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
. $toolsDir\helpers.ps1

$packageArgs = @{
  packageName            = 'libreoffice-fresh'
  version                = '7.1.4'
  fileType               = 'msi'
  url                    = 'https://download.documentfoundation.org/libreoffice/stable/7.1.4/win/x86/LibreOffice_7.1.4_Win_x86.msi'
  url64bit               = 'https://download.documentfoundation.org/libreoffice/stable/7.1.4/win/x86_64/LibreOffice_7.1.4_Win_x64.msi'
  checksum               = '9144abb3cf980e62061496083c339d8551d1c86940de8196dba854d24076cf6a'
  checksum64             = 'a7f0c4573085d0aa8f1dac7dbaf03764e4cf082a56ca95551630828f3a33f44d'
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
