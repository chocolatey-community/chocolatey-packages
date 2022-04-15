$ErrorActionPreference = 'Stop'

$toolsDir = Split-Path -Parent $MyInvocation.MyCommand.Definition

$packageArgs = @{
  packageName  = $env:ChocolateyPackageName
  url          = 'https://dl.maxthon.com/mx6/maxthon_portable_6.1.3.2020_x86.zip'
  checksum     = 'c252f5d0a88341382fbc0856c528d2a0524477c84c0f401ebe2ec0c3f8a25cdd'
  checksumType = 'sha256'
  destination  = $toolsDir
}

Install-ChocolateyZipPackage @packageArgs
