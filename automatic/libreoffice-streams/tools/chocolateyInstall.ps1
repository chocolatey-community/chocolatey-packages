$ErrorActionPreference = 'Stop'

$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
. $toolsDir\helpers.ps1

$packageArgs = @{
  packageName            = 'libreoffice-still'
  version                = '6.4.7'
  fileType               = 'msi'
  url                    = 'https://download.documentfoundation.org/libreoffice/stable/6.4.7/win/x86/LibreOffice_6.4.7_Win_x86.msi'
  url64bit               = 'https://download.documentfoundation.org/libreoffice/stable/6.4.7/win/x86_64/LibreOffice_6.4.7_Win_x64.msi'
  checksum               = 'd2ac8a5bb4febfce7b920c00a536c4df54109874e29923c2506105c59ce7fcb3'
  checksum64             = 'c4701958d57458dbdfa6cc6c80ab92e545aec8b4f1a15e358f16ad7ca8937ca9'
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
