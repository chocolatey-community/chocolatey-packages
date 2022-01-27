$ErrorActionPreference = 'Stop'

$toolsDir = Split-Path -Parent $MyInvocation.MyCommand.Definition

$packageArgs = @{
  packageName  = $env:ChocolateyPackageName
  url          = 'https://dl.maxthon.com/mx6/maxthon_portable_6.1.3.1001_x86.zip'
  checksum     = 'd0a229e8d1a369a43552fda77e70ba80c5c4ce37f0d686d2260f8d32d32c2271'
  checksumType = 'sha256'
  destination  = $toolsDir
}

Install-ChocolateyZipPackage @packageArgs
