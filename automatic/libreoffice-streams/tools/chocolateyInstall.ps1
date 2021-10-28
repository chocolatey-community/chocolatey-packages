$ErrorActionPreference = 'Stop'

$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
. $toolsDir\helpers.ps1

$packageArgs = @{
  packageName            = 'libreoffice-fresh'
  version                = '7.2.2'
  fileType               = 'msi'
  url                    = 'https://download.documentfoundation.org/libreoffice/stable/7.2.2/win/x86/LibreOffice_7.2.2_Win_x86.msi'
  url64bit               = 'https://download.documentfoundation.org/libreoffice/stable/7.2.2/win/x86_64/LibreOffice_7.2.2_Win_x64.msi'
  checksum               = '4486203b94812a7f4da62111bfbfed46dccf6402be036a5f8efebf76635f46d2'
  checksum64             = '422e733813bd853f37ef7731d75e554e73d3230c78b9bd58e39c0a8c2b6a45d0'
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
