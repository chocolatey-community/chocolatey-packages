$ErrorActionPreference = 'Stop'

$toolsPath = Split-Path -parent $MyInvocation.MyCommand.Definition

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  url            = 'https://github.com/Tribler/tribler/releases/download/v7.5.0/Tribler_7.5.0_x86.exe'
  url64          = 'https://github.com/Tribler/tribler/releases/download/v7.5.0/Tribler_7.5.0_x64.exe'
  checksum       = '32afe49e652a11aca2df68f4716d2e640372f2ad7b6eb1f3f4e61877943b3d66'
  checksumType   = 'sha256'
  checksum64     = '56ef057d20f19d18367cc024c2f634a83a6037039f442d845899982f52d7bf62'
  checksumType64 = 'sha256'
  softwareName   = 'Tribler'
  silentArgs     = '/S'
  validExitCodes = @(0, 1223)
}

Install-ChocolateyPackage @packageArgs
