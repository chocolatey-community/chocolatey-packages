$ErrorActionPreference = 'Stop'

$toolsPath = Split-Path -parent $MyInvocation.MyCommand.Definition

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  url            = 'https://github.com/Tribler/tribler/releases/download/v7.3.1/Tribler_7.3.1_x86.exe'
  url64          = 'https://github.com/Tribler/tribler/releases/download/v7.3.1/Tribler_7.3.1_x64.exe'
  checksum       = '11df20dda2301a721da1c1b6370f24d36a493af153e391288aead2a3d988bf03'
  checksumType   = 'sha256'
  checksum64     = '429ce8f5f6caca58d796f062ebfc969cddebc000eaf107d323d09cd055540049'
  checksumType64 = 'sha256'
  softwareName   = 'Tribler'
  silentArgs     = '/S'
  validExitCodes = @(0, 1223)
}

Install-ChocolateyPackage @packageArgs
