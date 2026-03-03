$ErrorActionPreference = 'Stop'

$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
. $toolsDir\helpers.ps1

$packageArgs = @{
  packageName            = 'libreoffice-still'
  version                = '25.8.5'
  fileType               = 'msi'
  url                    = 'https://download.documentfoundation.org/libreoffice/stable/25.8.5/win/x86/LibreOffice_25.8.5_Win_x86.msi'
  url64bit               = 'https://download.documentfoundation.org/libreoffice/stable/25.8.5/win/x86_64/LibreOffice_25.8.5_Win_x86-64.msi'
  checksum               = 'c86cfeb7feceb0c62069b36a2afeb18a30c82c8051d2864bd43cecbc3545adee'
  checksum64             = '379413c819d735ed995285c3dc240547171c266d39b4eb828d6e3d644e511bbe'
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
