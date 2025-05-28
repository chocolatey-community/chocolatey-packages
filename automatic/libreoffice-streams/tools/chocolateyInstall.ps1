$ErrorActionPreference = 'Stop'

$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
. $toolsDir\helpers.ps1

$packageArgs = @{
  packageName            = 'libreoffice-still'
  version                = '24.8.7'
  fileType               = 'msi'
  url                    = 'https://download.documentfoundation.org/libreoffice/stable/24.8.7/win/x86/LibreOffice_24.8.7_Win_x86.msi'
  url64bit               = 'https://download.documentfoundation.org/libreoffice/stable/24.8.7/win/x86_64/LibreOffice_24.8.7_Win_x86-64.msi'
  checksum               = '6d5532b73e50665516da546ce33aab7f903ea177096894135a626c571b262413'
  checksum64             = 'c9106c2b1d6f7f8527027d4c90228d66fc26b81eaa9546bd0be2b20a5d979aa9'
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
