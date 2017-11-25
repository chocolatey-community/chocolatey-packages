$ErrorActionPreference = 'Stop'

$toolsDir = Split-Path -Parent $MyInvocation.MyCommand.Definition

$packageArgs = @{
  packageName  = $env:ChocolateyPackageName
  url          = ''
  checksum     = ''
  checksumType = ''
  destination  = $toolsDir
}

Install-ChocolateyZipPackage @packageArgs
