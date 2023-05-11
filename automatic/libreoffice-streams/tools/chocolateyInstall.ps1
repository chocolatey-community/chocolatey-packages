$ErrorActionPreference = 'Stop'

$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
. $toolsDir\helpers.ps1

$packageArgs = @{
  packageName            = 'libreoffice-still'
  version                = '7.4.7'
  fileType               = 'msi'
  url                    = 'https://download.documentfoundation.org/libreoffice/stable/7.4.7/win/x86/LibreOffice_7.4.7_Win_x86.msi'
  url64bit               = 'https://download.documentfoundation.org/libreoffice/stable/7.4.7/win/x86_64/LibreOffice_7.4.7_Win_x64.msi'
  checksum               = '04526c830ce929ad52412c1e0fbb17c86d7a7598ed7b5f4038db992fb8cdee2c'
  checksum64             = '4a1e6eba5e7b095000a166ced3ad2412e913ea9b46a7dbed60d00b351df9cb77'
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
