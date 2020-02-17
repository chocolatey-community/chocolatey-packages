$ErrorActionPreference = 'Stop'

$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
. $toolsDir\helpers.ps1

$packageArgs = @{
  packageName            = 'libreoffice-fresh'
  version                = '6.3.4'
  fileType               = 'msi'
  url                    = 'https://download.documentfoundation.org/libreoffice/stable/6.3.4/win/x86/LibreOffice_6.3.4_Win_x86.msi'
  url64bit               = 'https://download.documentfoundation.org/libreoffice/stable/6.3.4/win/x86_64/LibreOffice_6.3.4_Win_x64.msi'
  checksum               = '95b6cb71df651646629266cf1be376fe938a6ecec8d141c61e403e3053047ff5'
  checksum64             = '94b2b86b5688685233479d594e5760ce24d5b9a00e33058f4b86dffd08b54574'
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
