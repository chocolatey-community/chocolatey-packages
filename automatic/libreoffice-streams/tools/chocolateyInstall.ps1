$ErrorActionPreference = 'Stop'

$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
. $toolsDir\helpers.ps1

$packageArgs = @{
  packageName            = 'libreoffice-still'
  version                = '7.3.7'
  fileType               = 'msi'
  url                    = 'https://download.documentfoundation.org/libreoffice/stable/7.3.7/win/x86/LibreOffice_7.3.7_Win_x86.msi'
  url64bit               = 'https://download.documentfoundation.org/libreoffice/stable/7.3.7/win/x86_64/LibreOffice_7.3.7_Win_x64.msi'
  checksum               = 'e2a0daf7086d6dd320c9f7d2a00879ebd9d64fd1362edc7498a4920cb9f0d110'
  checksum64             = '4b2cc5cce43ce7364ee307cf6542a8f26296bc409d292d69a4a8c70924384fd2'
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
