$ErrorActionPreference = 'Stop'

$toolsDir = Split-Path -Parent $MyInvocation.MyCommand.Definition

$packageArgs = @{
  packageName  = $env:ChocolateyPackageName
  url          = 'https://dl.maxthon.com/mx6/maxthon_portable_6.1.1.1000_x86.zip'
  checksum     = '9bd24c106adeee7936866d8ccc463fa27e4d34e3f815915a0c3299d1de29875a'
  checksumType = 'sha256'
  destination  = $toolsDir
}

Install-ChocolateyZipPackage @packageArgs
