$ErrorActionPreference = 'Stop'

$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
. $toolsDir\helpers.ps1

$packageArgs = @{
  packageName            = 'libreoffice-still'
  version                = '24.8.6'
  fileType               = 'msi'
  url                    = 'https://download.documentfoundation.org/libreoffice/stable/24.8.6/win/x86/LibreOffice_24.8.6_Win_x86.msi'
  url64bit               = 'https://download.documentfoundation.org/libreoffice/stable/24.8.6/win/x86_64/LibreOffice_24.8.6_Win_x86-64.msi'
  checksum               = 'fc0be798af2b647bf74ea0236b398d61b66b959b9e69b86d5f283ab43479ad65'
  checksum64             = '0c3d200b371eacb1d537865139da51e87653c04e96fec01fd8b6d7dd47499784'
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
