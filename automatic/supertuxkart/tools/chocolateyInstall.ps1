$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName    = 'supertuxkart'
  fileType       = 'exe'
  url            = 'https://sourceforge.net/projects/supertuxkart/files/SuperTuxKart/1.0/SuperTuxKart%201.0%20installer-32bit.exe/download'
  url64          = 'https://sourceforge.net/projects/supertuxkart/files/SuperTuxKart/1.0/SuperTuxKart%201.0%20installer-64bit.exe/download'
  checksum       = '9ba70c28bd024cdbb49062eef98543917272289953a7f3c17ed362f75b2dfa1d'
  checksum64     = '194776863e2418d2ff70f4b13b16811f7d360fc9424d9e5f16bcca1a83798bda'
  checksumType   = 'sha256'
  checksumType64 = 'sha256'
  silentArgs     = '/S'
  validExitCodes = @(0)
  softwareName   = 'supertuxkart*'
}
Install-ChocolateyPackage @packageArgs
