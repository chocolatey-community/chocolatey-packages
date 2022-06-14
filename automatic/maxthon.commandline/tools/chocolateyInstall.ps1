$ErrorActionPreference = 'Stop'

$toolsDir = Split-Path -Parent $MyInvocation.MyCommand.Definition

$packageArgs = @{
  packageName  = $env:ChocolateyPackageName
  url          = 'https://dl-space.maxthon.com/mx6/space/maxthon_portable_6.1.3.3000_x86.zip'
  checksum     = '82e15a71d84ad0ead5b737d3dad25379815529ca2726fb34351f1df343e37a96'
  checksumType = 'sha256'
  destination  = $toolsDir
}

Install-ChocolateyZipPackage @packageArgs
