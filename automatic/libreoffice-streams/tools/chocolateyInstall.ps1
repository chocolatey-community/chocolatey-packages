$ErrorActionPreference = 'Stop'

$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
. $toolsDir\helpers.ps1

$packageArgs = @{
  packageName            = 'libreoffice-fresh'
  version                = '7.1.0'
  fileType               = 'msi'
  url                    = 'https://download.documentfoundation.org/libreoffice/stable/7.1.0/win/x86/LibreOffice_7.1.0_Win_x86.msi'
  url64bit               = 'https://download.documentfoundation.org/libreoffice/stable/7.1.0/win/x86_64/LibreOffice_7.1.0_Win_x64.msi'
  checksum               = '258bae103cc76b01b943814c25fd37d1373c2b2e23a1f6c92d268510e708ed5f'
  checksum64             = '5ddb51955849dc4fe39933047c1b65d044ec5b01ff88e8b81e0a15d8de638aed'
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
