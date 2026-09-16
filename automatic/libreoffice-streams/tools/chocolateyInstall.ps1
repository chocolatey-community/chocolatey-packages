$ErrorActionPreference = 'Stop'

$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
. $toolsDir\helpers.ps1

$packageArgs = @{
  packageName            = 'libreoffice-fresh'
  version                = '26.2.4'
  fileType               = 'msi'
  url                    = 'https://downloadarchive.documentfoundation.org/libreoffice/old/26.2.4.2/win/x86/LibreOffice_26.2.4.2_Win_x86.msi'
  url64bit               = 'https://downloadarchive.documentfoundation.org/libreoffice/old/26.2.4.2/win/x86_64/LibreOffice_26.2.4.2_Win_x86-64.msi'
  checksum               = '8e3fd2d9f9e34e73fa9e71c9c60b7012c206dafb5879d502f338b86431beedad'
  checksum64             = '202f26cda071c5aa4996a5a28412fddceb3891dceb0366982c62650456c0730f'
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
