$ErrorActionPreference = 'Stop'

$toolsPath = Split-Path -parent $MyInvocation.MyCommand.Definition

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  url            = 'https://github.com/Tribler/tribler/releases/download/v7.12.0/Tribler_7.12.0_x86.exe'
  url64          = 'https://github.com/Tribler/tribler/releases/download/v7.12.0/Tribler_7.12.0_x64.exe'
  checksum       = 'fd15c64340ffd9ef205309a5a8789e7ce19fc1fdd4bcda84b03b29dc109942cf'
  checksumType   = 'sha256'
  checksum64     = 'c13ab7ab75e3706c834ae958a9fd13a3ccfe3f852c98860bcf86a16f3c33d43f'
  checksumType64 = 'sha256'
  softwareName   = 'Tribler'
  silentArgs     = '/S'
  validExitCodes = @(0, 1223)
}

Install-ChocolateyPackage @packageArgs
