$ErrorActionPreference = 'Stop'

$toolsDir = Split-Path -Parent $MyInvocation.MyCommand.Definition

$packageArgs = @{
  packageName  = $env:ChocolateyPackageName
  url          = 'http://dl.maxthon.com/mx5/maxthon_portable_5.2.7.4000.7z'
  checksum     = '92c6869a39d80a203e442b596e622cb883dc8f1a7dfa575a82d070775add7841'
  checksumType = 'sha256'
  destination  = $toolsDir
}

Install-ChocolateyZipPackage @packageArgs
