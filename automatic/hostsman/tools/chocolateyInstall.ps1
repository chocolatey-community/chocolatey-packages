$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName    = 'hostsman'
  url            = 'http://hostsman2.it-mate.co.uk/HostsMan_4.8.106.zip'
  checksum       = '36ca1ab6a2872919540d98bfad5d24cad93a380013aa74bf7618db24c015c1f5'
  checksumType   = 'sha256'
  unzipLocation  = Split-Path $MyInvocation.MyCommand.Definition
}
Install-ChocolateyZipPackage @packageArgs
