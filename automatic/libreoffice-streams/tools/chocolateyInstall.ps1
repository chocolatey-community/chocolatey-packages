$ErrorActionPreference = 'Stop'

$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
. $toolsDir\helpers.ps1

$packageArgs = @{
  packageName            = 'libreoffice-still'
  version                = '25.2.7'
  fileType               = 'msi'
  url                    = 'https://download.documentfoundation.org/libreoffice/stable/25.2.7/win/x86/LibreOffice_25.2.7_Win_x86.msi'
  url64bit               = 'https://download.documentfoundation.org/libreoffice/stable/25.2.7/win/x86_64/LibreOffice_25.2.7_Win_x86-64.msi'
  checksum               = '80339487132640e665a43924dfad16591b3bb150c585cb00d774f6d757b3d04c'
  checksum64             = '9fdd22f8ea7a92a67de5beaa08588ef6da58c1930ac86fd57c46b0c6d7ca9d34'
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
