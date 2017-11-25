$ErrorActionPreference = 'Stop'

$toolsDir = Split-Path -Parent $MyInvocation.MyCommand.Definition

$packageArgs = @{
  packageName  = $env:ChocolateyPackageName
  url          = 'https://dl.maxthon.com/mx5/maxthon_portable_5.1.3.2000.7z'
  checksum     = '3fa39ef0282dc35c80f7dd29a3bbe50968db62ecf11d3f97b65e38b13c047c68'
  checksumType = 'sha256'
  destination  = $toolsDir
}

Install-ChocolateyZipPackage @packageArgs
