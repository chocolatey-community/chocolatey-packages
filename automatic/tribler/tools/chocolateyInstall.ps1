$ErrorActionPreference = 'Stop'

$toolsPath = Split-Path -parent $MyInvocation.MyCommand.Definition

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  url            = 'https://github.com/Tribler/tribler/releases/download/v7.3.0/Tribler_7.3.0_x86.exe'
  url64          = 'https://github.com/Tribler/tribler/releases/download/v7.3.0/Tribler_7.3.0_x64.exe'
  checksum       = '8e792bdc6dc62932e43ea5c478da02b70d019c9300cfa458fd6ec6db0462d28b'
  checksumType   = 'sha256'
  checksum64     = '7929c6d036ca3e2d004d9bf16e091c579418a9c483cf2500822813d850d3b26e'
  checksumType64 = 'sha256'
  softwareName   = 'Tribler'
  silentArgs     = '/S'
  validExitCodes = @(0, 1223)
}

Install-ChocolateyPackage @packageArgs
