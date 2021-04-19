$ErrorActionPreference = 'Stop'

$toolsPath = Split-Path -parent $MyInvocation.MyCommand.Definition

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  url            = 'https://github.com/Tribler/tribler/releases/download/v7.9.0/Tribler_7.9.0_x86.exe'
  url64          = 'https://github.com/Tribler/tribler/releases/download/v7.9.0/Tribler_7.9.0_x64.exe'
  checksum       = '102cbf34d92809a9f09ce8c6058b1b43bfbbc8a52f3cd44327e2c764843bb227'
  checksumType   = 'sha256'
  checksum64     = 'cbb41ccb91004a264c1a7a3d7bc2084590af993502edcad3d4d9921e6bafb739'
  checksumType64 = 'sha256'
  softwareName   = 'Tribler'
  silentArgs     = '/S'
  validExitCodes = @(0, 1223)
}

Install-ChocolateyPackage @packageArgs
