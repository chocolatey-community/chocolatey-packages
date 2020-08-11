$ErrorActionPreference = 'Stop'

$toolsPath = Split-Path -parent $MyInvocation.MyCommand.Definition

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  url            = 'https://github.com/Tribler/tribler/releases/download/v7.5.2/Tribler_7.5.2_x86.exe'
  url64          = 'https://github.com/Tribler/tribler/releases/download/v7.5.2/Tribler_7.5.2_x64.exe'
  checksum       = 'd1c46ad9f49b76fd98a01e040d72e80d87ee5177101234a2d8cc420450dc4628'
  checksumType   = 'sha256'
  checksum64     = '8aa440b86f2866a0137908a3c8c87400b9b1394c293c8d94dda7b7eef3188cbd'
  checksumType64 = 'sha256'
  softwareName   = 'Tribler'
  silentArgs     = '/S'
  validExitCodes = @(0, 1223)
}

Install-ChocolateyPackage @packageArgs
