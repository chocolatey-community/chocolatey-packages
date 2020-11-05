$ErrorActionPreference = 'Stop'

$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
. $toolsDir\helpers.ps1

$packageArgs = @{
  packageName            = 'libreoffice-fresh'
  version                = '7.0.3'
  fileType               = 'msi'
  url                    = 'https://download.documentfoundation.org/libreoffice/stable/7.0.3/win/x86/LibreOffice_7.0.3_Win_x86.msi'
  url64bit               = 'https://download.documentfoundation.org/libreoffice/stable/7.0.3/win/x86_64/LibreOffice_7.0.3_Win_x64.msi'
  checksum               = 'de87555d8ac657a5cb154eaf618910526fa32a9661cf636471ee3e15b34969c8'
  checksum64             = '01d787c90ca3fe738f313bc183adec7d3e7c05451d9add03a43618d6f25efe60'
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
