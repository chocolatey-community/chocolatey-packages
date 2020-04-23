$ErrorActionPreference = 'Stop'

$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
. $toolsDir\helpers.ps1

$packageArgs = @{
  packageName            = 'libreoffice-fresh'
  version                = '6.4.3'
  fileType               = 'msi'
  url                    = 'https://download.documentfoundation.org/libreoffice/stable/6.4.3/win/x86/LibreOffice_6.4.3_Win_x86.msi'
  url64bit               = 'https://download.documentfoundation.org/libreoffice/stable/6.4.3/win/x86_64/LibreOffice_6.4.3_Win_x64.msi'
  checksum               = 'a6846a7947d0c727a4faa2eee26ed477d57616058bd115a5e6a4c00037d32208'
  checksum64             = 'f3ed5a1ac1d5e8b0ab0e60ee27b4da1ee45b286d51f84cb4ee1247d43aac0758'
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
