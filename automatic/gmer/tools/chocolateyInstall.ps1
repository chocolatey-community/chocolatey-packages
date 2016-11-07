$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName  = 'GMER'
  url          = ''
  checksum     = ''
  checksumType = ''
  unzipLocation = "$(split-path -parent $MyInvocation.MyCommand.Definition)"
}

Install-ChocolateyZipPackage @packageArgs
