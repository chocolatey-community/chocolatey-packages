$ErrorActionPreference = 'Stop'

$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
. $toolsDir\helpers.ps1

$packageArgs = @{
  packageName            = 'libreoffice-still'
  version                = '26.2.7'
  fileType               = 'msi'
  url                    = 'https://download.documentfoundation.org/libreoffice/stable/26.2.7/win/x86/LibreOffice_26.2.7_Win_x86.msi'
  url64bit               = 'https://download.documentfoundation.org/libreoffice/stable/26.2.7/win/x86_64/LibreOffice_26.2.7_Win_x86-64.msi'
  checksum               = 'c25adc5a23417d17694ab5932b474d154c7b8388bd0b86303031e4301d323e2e'
  checksum64             = '480fecf759fc6393bd614fbf43753eb95a8198fc1a065d41b727e3b664cd1e59'
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
