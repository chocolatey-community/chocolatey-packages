$ErrorActionPreference = 'Stop'

$toolsPath = Split-Path -parent $MyInvocation.MyCommand.Definition

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  url            = 'https://github.com/Tribler/tribler/releases/download/v8.0.6/Tribler_8.0.6_x86.exe'
  url64          = 'https://github.com/Tribler/tribler/releases/download/v8.0.6/Tribler_8.0.6_x64.exe'
  checksum       = 'a95dff49ed9492e3206557a2c6357375db3e08081830b3a5c72594e98a189d25'
  checksumType   = 'sha256'
  checksum64     = '264db20016c0c38a2f501831f358df2a0becfd9b9af7ab8d5f798cdf24b7c5ea'
  checksumType64 = 'sha256'
  softwareName   = 'Tribler'
  silentArgs     = '/S'
  validExitCodes = @(0, 1223)
}

Install-ChocolateyPackage @packageArgs
