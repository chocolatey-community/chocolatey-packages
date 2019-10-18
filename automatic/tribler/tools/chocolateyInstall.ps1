$ErrorActionPreference = 'Stop'

$toolsPath = Split-Path -parent $MyInvocation.MyCommand.Definition

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  url            = 'https://github.com/Tribler/tribler/releases/download/v7.3.2/Tribler_7.3.2_x86.exe'
  url64          = 'https://github.com/Tribler/tribler/releases/download/v7.3.2/Tribler_7.3.2_x64.exe'
  checksum       = '006aeaabb0fc39f5ea4311d61494fb094f024b9fff3605eae2d6e26b8e910dd0'
  checksumType   = 'sha256'
  checksum64     = 'f085332476670f62b307ad4f181c2e76f74aac75443070e7795b2343e8081dd3'
  checksumType64 = 'sha256'
  softwareName   = 'Tribler'
  silentArgs     = '/S'
  validExitCodes = @(0, 1223)
}

Install-ChocolateyPackage @packageArgs
