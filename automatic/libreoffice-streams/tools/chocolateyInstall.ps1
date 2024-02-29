$ErrorActionPreference = 'Stop'

$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
. $toolsDir\helpers.ps1

$packageArgs = @{
  packageName            = 'libreoffice-still'
  version                = '7.6.0'
  fileType               = 'msi'
  url                    = 'https://downloadarchive.documentfoundation.org/libreoffice/old/7.6.0.3/win/x86/LibreOffice_7.6.0.3_Win_x86.msi'
  url64bit               = 'https://downloadarchive.documentfoundation.org/libreoffice/old/7.6.0.3/win/x86_64/LibreOffice_7.6.0.3_Win_x86-64.msi'
  checksum               = 'd192043196a075013768b0eba86e29a87ee4dc9dc390d6dfe93fa418ffd3cf9c'
  checksum64             = 'f7e031ff87b06b57746fd8118038253432446c7a18857d18ede4c50f7770f592'
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
