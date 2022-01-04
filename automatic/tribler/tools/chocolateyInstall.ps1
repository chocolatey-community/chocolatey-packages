$ErrorActionPreference = 'Stop'

$toolsPath = Split-Path -parent $MyInvocation.MyCommand.Definition

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  url            = 'https://github.com/Tribler/tribler/releases/download/v7.11.0/Tribler_7.11.0_x86.exe'
  url64          = 'https://github.com/Tribler/tribler/releases/download/v7.11.0/Tribler_7.11.0_x64.exe'
  checksum       = '140a84808eaad0e2742a868db749efb99e3d71cb32679d50b14e9af14442735f'
  checksumType   = 'sha256'
  checksum64     = '9ec0311defbed36cea90340253dd4542712ce5b2ed4b19ef088f26860f751500'
  checksumType64 = 'sha256'
  softwareName   = 'Tribler'
  silentArgs     = '/S'
  validExitCodes = @(0, 1223)
}

Install-ChocolateyPackage @packageArgs
