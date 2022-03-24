$ErrorActionPreference = 'Stop'

$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
. $toolsDir\helpers.ps1

$packageArgs = @{
  packageName            = 'libreoffice-still'
  version                = '7.2.6'
  fileType               = 'msi'
  url                    = 'https://download.documentfoundation.org/libreoffice/stable/7.2.6/win/x86/LibreOffice_7.2.6_Win_x86.msi'
  url64bit               = 'https://download.documentfoundation.org/libreoffice/stable/7.2.6/win/x86_64/LibreOffice_7.2.6_Win_x64.msi'
  checksum               = 'bf2428db32392e85740e4232b9ccaa43d4220e0bc27b498a88f6eabac2a7bc01'
  checksum64             = '5e512ecf656acf7d3e2a644d2a15ef5c3990e6d7e872ce0cd82ade40637c61e2'
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
