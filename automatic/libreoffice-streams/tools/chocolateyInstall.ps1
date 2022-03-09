$ErrorActionPreference = 'Stop'

$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
. $toolsDir\helpers.ps1

$packageArgs = @{
  packageName            = 'libreoffice-still'
  version                = '7.2.0'
  fileType               = 'msi'
  url                    = 'https://downloadarchive.documentfoundation.org/libreoffice/old/7.2.0.4/win/x86/LibreOffice_7.2.0.4_Win_x86.msi'
  url64bit               = 'https://downloadarchive.documentfoundation.org/libreoffice/old/7.2.0.4/win/x86_64/LibreOffice_7.2.0.4_Win_x64.msi'
  checksum               = 'e3d5ff07a7e2aa0a8775c1ca303618d645ecce1496a1c179c232e38caa691cae'
  checksum64             = 'd2969415c10ca60a9dbcfe175df48bc38209690f69326af2639c3c75853db590'
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
