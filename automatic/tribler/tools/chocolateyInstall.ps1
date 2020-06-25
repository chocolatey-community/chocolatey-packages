$ErrorActionPreference = 'Stop'

$toolsPath = Split-Path -parent $MyInvocation.MyCommand.Definition

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  url            = 'https://github.com/Tribler/tribler/releases/download/v7.5.1/Tribler_7.5.1_x86.exe'
  url64          = 'https://github.com/Tribler/tribler/releases/download/v7.5.1/Tribler_7.5.1_x64.exe'
  checksum       = 'b0f7d5981627b551480b2b5ebadcdef01676178f4fce7c4c2259aab4e88e65a9'
  checksumType   = 'sha256'
  checksum64     = '70bced7dcd5b1f674c38a8b63615e671e3d86da08b27d1fb985ce6017f7168fe'
  checksumType64 = 'sha256'
  softwareName   = 'Tribler'
  silentArgs     = '/S'
  validExitCodes = @(0, 1223)
}

Install-ChocolateyPackage @packageArgs
