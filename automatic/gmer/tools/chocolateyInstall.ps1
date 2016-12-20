$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName  = 'GMER'
  url          = 'http://www2.gmer.net/gmer.zip'
  checksum     = 'de3abde117d7eacbb638bc7d0151f929cf80a4bb5e5beb1e390839e96fc6722a'
  checksumType = 'sha256'
  unzipLocation = "$(split-path -parent $MyInvocation.MyCommand.Definition)"
}

Install-ChocolateyZipPackage @packageArgs
