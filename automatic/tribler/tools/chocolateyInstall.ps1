$ErrorActionPreference = 'Stop'

$toolsPath = Split-Path -parent $MyInvocation.MyCommand.Definition

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  url            = 'https://github.com/Tribler/tribler/releases/download/v7.13.2/Tribler_7.13.2_x86.exe'
  url64          = 'https://github.com/Tribler/tribler/releases/download/v7.13.2/Tribler_7.13.2_x64.exe'
  checksum       = '6be687016d38f05fb8cd2183281b2c2666e9f8ec050fc1856b8ee7395e970174'
  checksumType   = 'sha256'
  checksum64     = '9a20eefcc5552384a6a3f61b42cbe37062c573b19cac161c18630f53bac5375c'
  checksumType64 = 'sha256'
  softwareName   = 'Tribler'
  silentArgs     = '/S'
  validExitCodes = @(0, 1223)
}

Install-ChocolateyPackage @packageArgs
