$ErrorActionPreference = 'Stop'

$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
. $toolsDir\helpers.ps1

$packageArgs = @{
  packageName            = 'libreoffice'
  version                = '6.2.5'
  fileType               = 'msi'
  url                    = 'https://download.documentfoundation.org/libreoffice/stable/6.2.5/win/x86/LibreOffice_6.2.5_Win_x86.msi'
  url64bit               = 'https://download.documentfoundation.org/libreoffice/stable/6.2.5/win/x86_64/LibreOffice_6.2.5_Win_x64.msi'
  checksum               = '717fb9e17a3feb8af1662e668b919db86fab343303b78f88c7859003056ee010'
  checksum64             = '9b01f6f382dbb31367e12cfb0ad4c684546f00edb20054eeac121e7e036a5389'
  checksumType           = 'sha256'
  checksumType64         = 'sha256'
  silentArgs             = ''
  validExitCodes         = @(0,3010)
  softwareName           = 'LibreOffice*'
}

if (-not IsUrlValid $packageArgs.url) {
  $exactVersion = GetLibOExactVersion $packageArgs.version
  $packageArgs.url = $exactVersion.Rows[0].Url32
  $packageArgs.url64bit = $exactVersion.Rows[0].Url64
}

Install-ChocolateyPackage @packageArgs