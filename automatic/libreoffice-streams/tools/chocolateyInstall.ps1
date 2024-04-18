$ErrorActionPreference = 'Stop'

$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
. $toolsDir\helpers.ps1

$packageArgs = @{
  packageName            = 'libreoffice-still'
  version                = '7.6.6'
  fileType               = 'msi'
  url                    = 'https://download.documentfoundation.org/libreoffice/stable/7.6.6/win/x86/LibreOffice_7.6.6_Win_x86.msi'
  url64bit               = 'https://download.documentfoundation.org/libreoffice/stable/7.6.6/win/x86_64/LibreOffice_7.6.6_Win_x86-64.msi'
  checksum               = '80243cc35151e03fde57650e63aa6a62174af1ff6f9ebb520d1070641b770a0d'
  checksum64             = '6570eb9362fa56dee557400d6b90967f18a5c442b4807dd5a56747ff760ae1bb'
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
