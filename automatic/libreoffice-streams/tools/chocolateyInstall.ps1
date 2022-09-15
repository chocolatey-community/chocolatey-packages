$ErrorActionPreference = 'Stop'

$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
. $toolsDir\helpers.ps1

$packageArgs = @{
  packageName            = 'libreoffice-still'
  version                = '7.3.6'
  fileType               = 'msi'
  url                    = 'https://download.documentfoundation.org/libreoffice/stable/7.3.6/win/x86/LibreOffice_7.3.6_Win_x86.msi'
  url64bit               = 'https://download.documentfoundation.org/libreoffice/stable/7.3.6/win/x86_64/LibreOffice_7.3.6_Win_x64.msi'
  checksum               = '8b7b9d6f8fe54eb846a03e021f488e872cb228f220f7ebd04169a5de23ef49f1'
  checksum64             = 'c7f478ef4ffa32351d6d01d474ff328b5918264c126ba601a8fdada1e6e35066'
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
