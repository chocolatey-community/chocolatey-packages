$ErrorActionPreference = 'Stop'

$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
. $toolsDir\helpers.ps1

$packageArgs = @{
  packageName            = 'libreoffice-fresh'
  version                = '24.8.3'
  fileType               = 'msi'
  url                    = 'https://download.documentfoundation.org/libreoffice/stable/24.8.3/win/x86/LibreOffice_24.8.3_Win_x86.msi'
  url64bit               = 'https://download.documentfoundation.org/libreoffice/stable/24.8.3/win/x86_64/LibreOffice_24.8.3_Win_x86-64.msi'
  checksum               = 'e2baa7bf7b7f5f835bfd90f05cda0cecfe3383eb5b9bbc350c97dd6cb0edba23'
  checksum64             = 'b1808dbe14b22bb358a09f0edf83ab591e9d43b37dcd9dd35ff3880b85f1ad90'
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
