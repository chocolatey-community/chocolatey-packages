$ErrorActionPreference = 'Stop'

$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
. $toolsDir\helpers.ps1

$packageArgs = @{
  packageName            = 'libreoffice-still'
  version                = '25.2.0'
  fileType               = 'msi'
  url                    = 'https://downloadarchive.documentfoundation.org/libreoffice/old/25.2.0.3/win/x86/LibreOffice_25.2.0.3_Win_x86.msi'
  url64bit               = 'https://downloadarchive.documentfoundation.org/libreoffice/old/25.2.0.3/win/x86_64/LibreOffice_25.2.0.3_Win_x86-64.msi'
  checksum               = 'b3d6323541985f24dfff43b0ad326643aad91a309b0e0a18a016817ea28a8a35'
  checksum64             = 'b6dddfa75ed037910cab669d1dd58f68a129cd9b61072472cd5ddcf9c33f1bb9'
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
