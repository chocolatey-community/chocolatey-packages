$ErrorActionPreference = 'Stop'

$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
. $toolsDir\helpers.ps1

$packageArgs = @{
  packageName            = 'libreoffice-still'
  version                = '7.0.5'
  fileType               = 'msi'
  url                    = 'https://download.documentfoundation.org/libreoffice/stable/7.0.5/win/x86/LibreOffice_7.0.5_Win_x86.msi'
  url64bit               = 'https://download.documentfoundation.org/libreoffice/stable/7.0.5/win/x86_64/LibreOffice_7.0.5_Win_x64.msi'
  checksum               = '6a3820c0bba7443e1e2d208e22274367a7b4f9d3be03c996ae187ce2c0c7c00c'
  checksum64             = 'd5cc1613f56f54058b02701c8f7bea80ec20a452b2ba48099bd49350e2f05955'
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
