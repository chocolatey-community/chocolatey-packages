$ErrorActionPreference = 'Stop'

$toolsPath = Split-Path -parent $MyInvocation.MyCommand.Definition

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  url            = 'https://github.com/Tribler/tribler/releases/download/v7.5.3/Tribler_7.5.3_x86.exe'
  url64          = 'https://github.com/Tribler/tribler/releases/download/v7.5.3/Tribler_7.5.3_x64.exe'
  checksum       = 'a4722988d961807ce086b97b16ec9fd5d37afda9a006571f76292057265269e1'
  checksumType   = 'sha256'
  checksum64     = '6ea33a243edf9f29f024feea533bcb9f594b9e416e77481784d823bbeeb46eab'
  checksumType64 = 'sha256'
  softwareName   = 'Tribler'
  silentArgs     = '/S'
  validExitCodes = @(0, 1223)
}

Install-ChocolateyPackage @packageArgs
