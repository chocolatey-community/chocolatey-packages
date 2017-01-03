$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName    = 'hostsman'
  url            = 'http://hostsman2.it-mate.co.uk/HostsMan_4.7.105.zip'
  checksum       = 'b98f1155cda04e8a96cf29f6cc68497bdb28add7c8317cae79f6ec34c3bdc7fa'
  checksumType   = 'sha256'
  unzipLocation  = Split-Path $MyInvocation.MyCommand.Definition
}
Install-ChocolateyZipPackage @packageArgs
