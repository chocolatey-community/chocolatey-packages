$ErrorActionPreference = 'Stop'

$toolsDir = Split-Path -Parent $MyInvocation.MyCommand.Definition

$packageArgs = @{
  packageName  = $env:ChocolateyPackageName
  url          = 'http://dl.maxthon.com/mx5/maxthon_portable_5.2.7.1000.7z'
  checksum     = 'd895bc291f7be0e27a814542d0df7d2cf1eee8861ed8e2f63a933658e2d3a68c'
  checksumType = 'sha256'
  destination  = $toolsDir
}

Install-ChocolateyZipPackage @packageArgs
