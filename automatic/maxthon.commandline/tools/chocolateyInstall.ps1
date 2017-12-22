$ErrorActionPreference = 'Stop'

$toolsDir = Split-Path -Parent $MyInvocation.MyCommand.Definition

$packageArgs = @{
  packageName  = $env:ChocolateyPackageName
  url          = 'https://dl.maxthon.com/mx5/maxthon_portable_5.1.4.3000.7z'
  checksum     = 'e1d3805aa34f02696baf4b14554c3d58291852c4366d6fb6cd375ed2737cded1'
  checksumType = 'sha256'
  destination  = $toolsDir
}

Install-ChocolateyZipPackage @packageArgs
