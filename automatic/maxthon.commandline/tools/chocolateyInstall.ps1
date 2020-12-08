$ErrorActionPreference = 'Stop'

$toolsDir = Split-Path -Parent $MyInvocation.MyCommand.Definition

$packageArgs = @{
  packageName  = $env:ChocolateyPackageName
  url          = 'https://dl.maxthon.com/mx6/maxthon_portable_6.1.0.2000_x86.7z'
  checksum     = '76d1de0cdd0e4a926153b85f980a4e7dfea7c128f316df6d13265abad4475117'
  checksumType = 'sha256'
  destination  = $toolsDir
}

Install-ChocolateyZipPackage @packageArgs
