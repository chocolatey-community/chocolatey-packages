$ErrorActionPreference = 'Stop'

$toolsPath = Split-Path -parent $MyInvocation.MyCommand.Definition

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  url            = 'https://github.com/Tribler/tribler/releases/download/v7.14.0/Tribler_7.14.0_x86.exe'
  url64          = 'https://github.com/Tribler/tribler/releases/download/v7.14.0/Tribler_7.14.0_x64.exe'
  checksum       = '63ec1c97b692959bc011c6420cab1984477ad238c2c2332d80cc5f339f1d80f0'
  checksumType   = 'sha256'
  checksum64     = 'd90f3d02cd5563375120293d62982df87b9a8e904cd5a20a05f7f2a7620cd756'
  checksumType64 = 'sha256'
  softwareName   = 'Tribler'
  silentArgs     = '/S'
  validExitCodes = @(0, 1223)
}

Install-ChocolateyPackage @packageArgs
