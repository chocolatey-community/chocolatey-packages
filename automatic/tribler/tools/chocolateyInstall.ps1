$ErrorActionPreference = 'Stop'

$toolsPath = Split-Path -parent $MyInvocation.MyCommand.Definition

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  url            = 'https://github.com/Tribler/tribler/releases/download/v7.13.1/Tribler_7.13.1_x86.exe'
  url64          = 'https://github.com/Tribler/tribler/releases/download/v7.13.1/Tribler_7.13.1_x64.exe'
  checksum       = '4ebad70718b4eec10b83db0c754d19532072f23511f874a1ef45091f87d986f6'
  checksumType   = 'sha256'
  checksum64     = '5164fe4e1c3b70c27119c3aea7ca01a25d549a2259b2f8a179e55e41f8b22771'
  checksumType64 = 'sha256'
  softwareName   = 'Tribler'
  silentArgs     = '/S'
  validExitCodes = @(0, 1223)
}

Install-ChocolateyPackage @packageArgs
