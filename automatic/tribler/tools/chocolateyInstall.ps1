$ErrorActionPreference = 'Stop'

$toolsPath = Split-Path -parent $MyInvocation.MyCommand.Definition

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  url            = 'https://github.com/Tribler/tribler/releases/download/v8.0.7/Tribler_8.0.7_x86.exe'
  url64          = 'https://github.com/Tribler/tribler/releases/download/v8.0.7/Tribler_8.0.7_x64.exe'
  checksum       = 'c48c0ef9fd7440e2c48e3cd1a5eadaba81cc0e2189a573a872eb1e47bf4eb32e'
  checksumType   = 'sha256'
  checksum64     = '80b4587d36a54bdb9d0039196d5e72a67dd9c0b6b0307f277b0b3fb3e232107b'
  checksumType64 = 'sha256'
  softwareName   = 'Tribler'
  silentArgs     = '/S'
  validExitCodes = @(0, 1223)
}

Install-ChocolateyPackage @packageArgs
