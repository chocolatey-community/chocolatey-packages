$ErrorActionPreference = 'Stop'

$toolsDir = Split-Path -Parent $MyInvocation.MyCommand.Definition

$packageArgs = @{
  packageName  = $env:ChocolateyPackageName
  url          = 'https://dl.maxthon.com/mx5/maxthon_portable_5.1.5.1000.7z'
  checksum     = '0ce03b62fc67c4f85fb9cf1512880a55d42fde4eafff8883339e78e1c03d4646'
  checksumType = 'sha256'
  destination  = $toolsDir
}

Install-ChocolateyZipPackage @packageArgs
