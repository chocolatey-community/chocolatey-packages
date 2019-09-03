$ErrorActionPreference = 'Stop'

$toolsDir = Split-Path -Parent $MyInvocation.MyCommand.Definition

$packageArgs = @{
  packageName  = $env:ChocolateyPackageName
  url          = 'http://dl.maxthon.com/mx5/maxthon_portable_5.2.7.5000.7z'
  checksum     = '913f3e413dced372fdb1f51863c02735dc1f0f375c0c905bb4ce134616291b1b'
  checksumType = 'sha256'
  destination  = $toolsDir
}

Install-ChocolateyZipPackage @packageArgs
