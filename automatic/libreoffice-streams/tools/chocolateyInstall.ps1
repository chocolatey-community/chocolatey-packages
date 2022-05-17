$ErrorActionPreference = 'Stop'

$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
. $toolsDir\helpers.ps1

$packageArgs = @{
  packageName            = 'libreoffice-still'
  version                = '7.2.7'
  fileType               = 'msi'
  url                    = 'https://download.documentfoundation.org/libreoffice/stable/7.2.7/win/x86/LibreOffice_7.2.7_Win_x86.msi'
  url64bit               = 'https://download.documentfoundation.org/libreoffice/stable/7.2.7/win/x86_64/LibreOffice_7.2.7_Win_x64.msi'
  checksum               = '99ccc38a3f0ec79897a851a933cf9f0739c661a4e7974d2f1005022285d59019'
  checksum64             = '3b9fb5de768ad5a4b460832bca16cac58aab9f36cb39ec2270075bae94c57aac'
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
