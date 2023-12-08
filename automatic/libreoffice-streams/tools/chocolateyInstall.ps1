$ErrorActionPreference = 'Stop'

$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
. $toolsDir\helpers.ps1

$packageArgs = @{
  packageName            = 'libreoffice-still'
  version                = '7.5.9'
  fileType               = 'msi'
  url                    = 'https://download.documentfoundation.org/libreoffice/stable/7.5.9/win/x86/LibreOffice_7.5.9_Win_x86.msi'
  url64bit               = 'https://download.documentfoundation.org/libreoffice/stable/7.5.9/win/x86_64/LibreOffice_7.5.9_Win_x86-64.msi'
  checksum               = '4589fb6d7588b66baaac0ebdffe509d315e94d2281b20e7f19107f562a408d8f'
  checksum64             = '82d744eb8c3b19bc05ce3f2f363d7a6987432cdba2f495f0c019f5d0b83dfa62'
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
