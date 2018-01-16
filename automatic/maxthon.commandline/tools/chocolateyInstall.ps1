$ErrorActionPreference = 'Stop'

$toolsDir = Split-Path -Parent $MyInvocation.MyCommand.Definition

$packageArgs = @{
  packageName  = $env:ChocolateyPackageName
  url          = 'https://dl.maxthon.com/mx5/maxthon_portable_5.1.5.3000.7z'
  checksum     = '8e23221b3f9b91e351c8cd844cebe7a43f6004d8dbac29391ee82f9f27179e60'
  checksumType = 'sha256'
  destination  = $toolsDir
}

Install-ChocolateyZipPackage @packageArgs
