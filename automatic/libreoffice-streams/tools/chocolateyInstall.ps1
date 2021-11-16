$ErrorActionPreference = 'Stop'

$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
. $toolsDir\helpers.ps1

$packageArgs = @{
  packageName            = 'libreoffice-still'
  version                = '7.1.7'
  fileType               = 'msi'
  url                    = 'https://download.documentfoundation.org/libreoffice/stable/7.1.7/win/x86/LibreOffice_7.1.7_Win_x86.msi'
  url64bit               = 'https://download.documentfoundation.org/libreoffice/stable/7.1.7/win/x86_64/LibreOffice_7.1.7_Win_x64.msi'
  checksum               = '1ec0e016820f2165b147120057d888c121fdccfd95406ec6a0f4eb5a6b9c8a06'
  checksum64             = '7a15d4d26ce04d65d6d4e1b58919168f1c1b8ef2eb2147785bdad4e1fff25092'
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
