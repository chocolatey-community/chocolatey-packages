$ErrorActionPreference = 'Stop'

$toolsPath = Split-Path -parent $MyInvocation.MyCommand.Definition

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  url            = 'https://github.com/Tribler/tribler/releases/download/v7.4.4/Tribler_7.4.4_x86.exe'
  url64          = 'https://github.com/Tribler/tribler/releases/download/v7.4.4/Tribler_7.4.4_x64.exe'
  checksum       = '0256d465db7c70883f1a287b2801889c2e5d247a249eb0bd5fb8353ee76e95b6'
  checksumType   = 'sha256'
  checksum64     = '97e984f1bd99f0188933327655f19403b651eb5c70007ec087fe36a0c469d025'
  checksumType64 = 'sha256'
  softwareName   = 'Tribler'
  silentArgs     = '/S'
  validExitCodes = @(0, 1223)
}

Install-ChocolateyPackage @packageArgs
