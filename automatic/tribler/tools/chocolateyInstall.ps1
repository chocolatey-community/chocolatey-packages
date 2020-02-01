$ErrorActionPreference = 'Stop'

$toolsPath = Split-Path -parent $MyInvocation.MyCommand.Definition

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  url            = 'https://github.com/Tribler/tribler/releases/download/v7.4.0/Tribler_7.4.0_x86.exe'
  url64          = 'https://github.com/Tribler/tribler/releases/download/v7.4.0/Tribler_7.4.0_x64.exe'
  checksum       = '548127f98ded2d32864f76784c266d93bed98de3f71606bbfc0df6cdd1aaba5b'
  checksumType   = 'sha256'
  checksum64     = 'fda3e1aaecaf58b1c410d7e92f2f75e4e42bcb10c6d52a7a6cbbb7677ab1d3dc'
  checksumType64 = 'sha256'
  softwareName   = 'Tribler'
  silentArgs     = '/S'
  validExitCodes = @(0, 1223)
}

Install-ChocolateyPackage @packageArgs
