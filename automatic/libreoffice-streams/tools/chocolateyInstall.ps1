$ErrorActionPreference = 'Stop'

$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
. $toolsDir\helpers.ps1

$packageArgs = @{
  packageName            = 'libreoffice-fresh'
  version                = '25.2.4'
  fileType               = 'msi'
  url                    = 'https://download.documentfoundation.org/libreoffice/stable/25.2.4/win/x86/LibreOffice_25.2.4_Win_x86.msi'
  url64bit               = 'https://download.documentfoundation.org/libreoffice/stable/25.2.4/win/x86_64/LibreOffice_25.2.4_Win_x86-64.msi'
  checksum               = '380bbdd36593d725aa288894f988accaf40cea8b932bff41998cea92a42a9036'
  checksum64             = 'a985d08e5311f0fdefbf6b0a599b60112d1fcd388d7ad34121e0be53d597b048'
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
