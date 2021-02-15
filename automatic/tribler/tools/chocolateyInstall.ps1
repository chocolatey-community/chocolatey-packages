$ErrorActionPreference = 'Stop'

$toolsPath = Split-Path -parent $MyInvocation.MyCommand.Definition

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  url            = 'https://github.com/Tribler/tribler/releases/download/v7.8.0/Tribler_7.8.0_x86.exe'
  url64          = 'https://github.com/Tribler/tribler/releases/download/v7.8.0/Tribler_7.8.0_x64.exe'
  checksum       = 'bef5fcafd39d5314bc375ba4e46ef11b05fa5cb5d6197428a046cdbd5e88cb71'
  checksumType   = 'sha256'
  checksum64     = 'd8f4cd9cbe5161231daa2fff129a9028961ad37b16cd92234df81d1a03ad2f0e'
  checksumType64 = 'sha256'
  softwareName   = 'Tribler'
  silentArgs     = '/S'
  validExitCodes = @(0, 1223)
}

Install-ChocolateyPackage @packageArgs
