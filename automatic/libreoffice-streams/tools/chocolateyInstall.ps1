$ErrorActionPreference = 'Stop'

$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
. $toolsDir\helpers.ps1

$packageArgs = @{
  packageName            = 'libreoffice-fresh'
  version                = '7.1.5'
  fileType               = 'msi'
  url                    = 'https://download.documentfoundation.org/libreoffice/stable/7.1.5/win/x86/LibreOffice_7.1.5_Win_x86.msi'
  url64bit               = 'https://download.documentfoundation.org/libreoffice/stable/7.1.5/win/x86_64/LibreOffice_7.1.5_Win_x64.msi'
  checksum               = '0ac287930cdf7fcbfac6966611143a68af302beefda1e70b991eeef42b2c6b30'
  checksum64             = '0512d1015473956b501b695ff003edc942b1ea0d52595934f0ce4beb9929d8b7'
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
