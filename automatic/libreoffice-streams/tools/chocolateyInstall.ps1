$ErrorActionPreference = 'Stop'

$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
. $toolsDir\helpers.ps1

$packageArgs = @{
  packageName            = 'libreoffice-fresh'
  version                = '6.4.0'
  fileType               = 'msi'
  url                    = 'https://downloadarchive.documentfoundation.org/libreoffice/old/6.4.0.3/win/x86/LibreOffice_6.4.0.3_Win_x86.msi'
  url64bit               = 'https://downloadarchive.documentfoundation.org/libreoffice/old/6.4.0.3/win/x86_64/LibreOffice_6.4.0.3_Win_x64.msi'
  checksum               = '357b9dee3c762e2ecece604f5e7512181dc1f6a0b5169b550037d8af935c5f87'
  checksum64             = '4fd83acacebdaed54003804a7518224e205542d17bd517cb8b87fc2adb5e94b6'
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
