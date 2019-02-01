$ErrorActionPreference = 'Stop'

$toolsPath = Split-Path -parent $MyInvocation.MyCommand.Definition

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  url            = 'https://github.com/Tribler/tribler/releases/download/v7.2.1/Tribler_7.2.1_x86.exe'
  url64          = 'https://github.com/Tribler/tribler/releases/download/v7.2.1/Tribler_7.2.1_x64.exe'
  checksum       = 'c73bd7acf2ff55a0ce8156ac20849cac6d4ed57bda43484ef3c978fbb4b40395'
  checksumType   = 'sha256'
  checksum64     = 'e92dfbdd95956c767ab3f6b5c88b930a6d60ac8ea2038e088851c664d87fe3f3'
  checksumType64 = 'sha256'
  softwareName   = 'Tribler'
  silentArgs     = '/S'
  validExitCodes = @(0, 1223)
}

Install-ChocolateyPackage @packageArgs
