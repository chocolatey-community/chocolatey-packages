$ErrorActionPreference = 'Stop';

$packageArgs = @{
  packageName   = 'palemoon'
  fileType      = 'exe'
  url           = 'https://rm-eu.palemoon.org/release/palemoon-32.4.1.win32.installer.exe'
  url64         = 'https://rm-eu.palemoon.org/release/palemoon-32.4.1.win64.installer.exe'

  softwareName  = 'Pale Moon*'

  checksum      = '21fedf732f71fc5424339d28ea29b07ec666db4d9ce20edd003db4512dd49509'
  checksumType  = 'sha256'
  checksum64    = '8cd4e52e2ce731bca2073b806015a7a81b1364ef7d40e6ebe9686a2d6a30d6d9'
  checksumType64= 'sha256'

  silentArgs    = "/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-"
  validExitCodes= @(0)
}

Install-ChocolateyPackage @packageArgs
