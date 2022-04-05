$ErrorActionPreference = 'Stop'

$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
. $toolsDir\helpers.ps1

$packageArgs = @{
  packageName            = 'libreoffice-fresh'
  version                = '7.3.2'
  fileType               = 'msi'
  url                    = 'https://download.documentfoundation.org/libreoffice/stable/7.3.2/win/x86/LibreOffice_7.3.2_Win_x86.msi'
  url64bit               = 'https://download.documentfoundation.org/libreoffice/stable/7.3.2/win/x86_64/LibreOffice_7.3.2_Win_x64.msi'
  checksum               = '05892f2b496ef70e0507fd9a9decf591eda99bb153489513311b827434be95d7'
  checksum64             = 'f883840d2f5ec5e11aa58e8ffdab076e470c475f4092c49d63cf57eb8271fcea'
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
