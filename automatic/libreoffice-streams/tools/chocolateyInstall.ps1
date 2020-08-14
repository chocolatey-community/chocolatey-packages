$ErrorActionPreference = 'Stop'

$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
. $toolsDir\helpers.ps1

$packageArgs = @{
  packageName            = 'libreoffice-fresh'
  version                = '6.4.6'
  fileType               = 'msi'
  url                    = 'https://download.documentfoundation.org/libreoffice/stable/6.4.6/win/x86/LibreOffice_6.4.6_Win_x86.msi'
  url64bit               = 'https://download.documentfoundation.org/libreoffice/stable/6.4.6/win/x86_64/LibreOffice_6.4.6_Win_x64.msi'
  checksum               = '64c1e57096f034557724397cac4a329bd1d47c4347f3e531612b79739e77baaa'
  checksum64             = 'ac0ec1a2f4d4138c90a7ff3af849560702147e13f7ed83334871280c6dbbce64'
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
