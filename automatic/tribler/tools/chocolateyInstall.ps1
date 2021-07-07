$ErrorActionPreference = 'Stop'

$toolsPath = Split-Path -parent $MyInvocation.MyCommand.Definition

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  url            = 'https://github.com/Tribler/tribler/releases/download/v7.10.0/Tribler_7.10.0_x86.exe'
  url64          = 'https://github.com/Tribler/tribler/releases/download/v7.10.0/Tribler_7.10.0_x64.exe'
  checksum       = 'c529114391eea35bfec31025f405e9cd731c4ee9f311c852b2f2fd451051ee83'
  checksumType   = 'sha256'
  checksum64     = '20715c8d5a749da42d05b18c99586717de41af504f911011324cf16a89d33736'
  checksumType64 = 'sha256'
  softwareName   = 'Tribler'
  silentArgs     = '/S'
  validExitCodes = @(0, 1223)
}

Install-ChocolateyPackage @packageArgs
