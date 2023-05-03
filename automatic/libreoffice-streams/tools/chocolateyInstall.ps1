$ErrorActionPreference = 'Stop'

$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
. $toolsDir\helpers.ps1

$packageArgs = @{
  packageName            = 'libreoffice-fresh'
  version                = '7.5.2'
  fileType               = 'msi'
  url                    = 'https://download.documentfoundation.org/libreoffice/stable/7.5.2/win/x86/LibreOffice_7.5.2_Win_x86.msi'
  url64bit               = 'https://download.documentfoundation.org/libreoffice/stable/7.5.2/win/x86_64/LibreOffice_7.5.2_Win_x86-64.msi'
  checksum               = '7252c6e5620cffde824f248e23d67990a5b36aaf9fbde33bb865dbf7e90d3fe0'
  checksum64             = '638e93876e8345666f1cf3e968373a90add5d420094a6ec8871edcda94a440e8'
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
