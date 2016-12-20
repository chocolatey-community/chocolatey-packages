$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName    = 'hostsman'
  url            = 'http://hostsman2.it-mate.co.uk/HostsMan_4.6.103.zip'
  checksum       = 'A9E5CCDF9734297517772DAD0BE19918EEF8A5837FD78DF8788766B78ECEA8DC'
  checksumType   = 'sha256'
  unzipLocation  = Split-Path $MyInvocation.MyCommand.Definition
}
Install-ChocolateyZipPackage @packageArgs
