$ErrorActionPreference = 'Stop'

$toolsDir = Split-Path -Parent $MyInvocation.MyCommand.Definition

$packageArgs = @{
  packageName  = $env:ChocolateyPackageName
  url          = 'https://dl.maxthon.com/mx6/maxthon_portable_6.1.2.3000_x86.zip'
  checksum     = '9ede7e558fadcd17e9f937161f059b7178a95d48d26bf23eb47bc57cfa06ac5e'
  checksumType = 'sha256'
  destination  = $toolsDir
}

Install-ChocolateyZipPackage @packageArgs
