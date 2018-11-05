$ErrorActionPreference = 'Stop'

$toolsDir = Split-Path -Parent $MyInvocation.MyCommand.Definition

$packageArgs = @{
  packageName  = $env:ChocolateyPackageName
  url          = 'http://dl.maxthon.com/mx5/maxthon_portable_5.2.5.3000.7z'
  checksum     = '71f65a8330106d3519ef42060bff8ce280440134c61002d7b823259d402de263'
  checksumType = 'sha256'
  destination  = $toolsDir
}

Install-ChocolateyZipPackage @packageArgs
