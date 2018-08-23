$ErrorActionPreference = 'Stop'

$toolsDir = Split-Path -Parent $MyInvocation.MyCommand.Definition

$packageArgs = @{
  packageName  = $env:ChocolateyPackageName
  url          = 'http://dl.maxthon.com/mx5/maxthon_portable_5.2.4.2000.7z'
  checksum     = 'ee28c76d2b31963026897192ba6ce9f7ed89e6722ecfa090187bb17690ba3b5c'
  checksumType = 'sha256'
  destination  = $toolsDir
}

Install-ChocolateyZipPackage @packageArgs
