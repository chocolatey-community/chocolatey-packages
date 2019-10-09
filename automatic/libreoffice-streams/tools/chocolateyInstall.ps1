$ErrorActionPreference = 'Stop'

$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
. $toolsDir\helpers.ps1

$packageArgs = @{
  packageName            = 'libreoffice'
  version                = ''
  fileType               = 'msi'
  url                    = ''
  url64bit               = ''
  checksum               = ''
  checksum64             = ''
  checksumType           = 'sha256'
  checksumType64         = 'sha256'
  silentArgs             = '/passive /norestart /l*v "$Env:TEMP\chocolatey\$Env:ChocolateyPackageName\$Env:ChocolateyPackageVersion\install.log"'
  validExitCodes         = @(0,3010)
  softwareName           = 'LibreOffice*'
}

if (-not (IsUrlValid $packageArgs.url)) {
  $exactVersion = GetLibOExactVersion $packageArgs.version
  $packageArgs.url = $exactVersion.Rows[0].Url32
  $packageArgs.url64bit = $exactVersion.Rows[0].Url64
}

Install-ChocolateyPackage @packageArgs
