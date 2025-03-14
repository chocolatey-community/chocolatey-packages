$ErrorActionPreference = 'Stop'

$toolsPath = Split-Path -parent $MyInvocation.MyCommand.Definition

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  url            = 'https://github.com/Tribler/tribler/releases/download/v8.1.2/Tribler_8.1.2_x86.exe'
  url64          = 'https://github.com/Tribler/tribler/releases/download/v8.1.2/Tribler_8.1.2_x64.exe'
  checksum       = '137e91ebdd97be4a9d8361fd3005f0ddf8076f96a3fa2694b8cfdbe1c45ed991'
  checksumType   = 'sha256'
  checksum64     = 'fa2679abeb9aea744a8301b7441eaf4f84e6003ab4b466e94f577304e06249c7'
  checksumType64 = 'sha256'
  softwareName   = 'Tribler'
  silentArgs     = '/S'
  validExitCodes = @(0, 1223)
}

Install-ChocolateyPackage @packageArgs
