$ErrorActionPreference = 'Stop'

$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
. $toolsDir\helpers.ps1

$packageArgs = @{
  packageName            = 'libreoffice-fresh'
  version                = '7.4.2'
  fileType               = 'msi'
  url                    = 'https://download.documentfoundation.org/libreoffice/stable/7.4.2/win/x86/LibreOffice_7.4.2_Win_x86.msi'
  url64bit               = 'https://download.documentfoundation.org/libreoffice/stable/7.4.2/win/x86_64/LibreOffice_7.4.2_Win_x64.msi'
  checksum               = '64732d57588cd08ecefe3bcffdfc0e0f3db2059260b4ba0491b60a1f9aadfcc2'
  checksum64             = '4590009b0800ff372de74e6e81f95b783c998570e46079de38aae26c9c33f61e'
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
