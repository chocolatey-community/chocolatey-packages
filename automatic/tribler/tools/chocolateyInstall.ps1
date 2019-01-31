$ErrorActionPreference = 'Stop'

$toolsPath = Split-Path -parent $MyInvocation.MyCommand.Definition

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  url            = 'https://github.com/Tribler/tribler/releases/download/v7.2.0/Tribler_7.2.0_x86.exe'
  url64          = 'https://github.com/Tribler/tribler/releases/download/v7.2.0/Tribler_7.2.0_x64.exe'
  checksum       = '8844795afa5869f01150152653cd56dab6e0a2094e3f6e0a5d32030b34567bdc'
  checksumType   = 'sha256'
  checksum64     = '890837de6903da1794239837a8f50e24079abbd065b1049fb58cf47448f2c588'
  checksumType64 = 'sha256'
  softwareName   = 'Tribler'
  silentArgs     = '/S'
  validExitCodes = @(0, 1223)
}

Install-ChocolateyPackage @packageArgs
