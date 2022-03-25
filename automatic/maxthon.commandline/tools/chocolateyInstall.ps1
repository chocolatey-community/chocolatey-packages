$ErrorActionPreference = 'Stop'

$toolsDir = Split-Path -Parent $MyInvocation.MyCommand.Definition

$packageArgs = @{
  packageName  = $env:ChocolateyPackageName
  url          = 'https://dl-space.maxthon.com/mx6/space/maxthon_portable_6.1.3.2000_x86.zip'
  checksum     = 'f2795c98d8382ed2c9adb9aab09f885ac0071518c775dd337385e4b0fa92965d'
  checksumType = 'sha256'
  destination  = $toolsDir
}

Install-ChocolateyZipPackage @packageArgs
