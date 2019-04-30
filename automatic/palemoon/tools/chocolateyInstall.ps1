$ErrorActionPreference = 'Stop';

$packageArgs = @{
  packageName   = 'palemoon'
  fileType      = 'exe'
  url           = 'http://rm-eu.palemoon.org/release/palemoon-28.5.0.win32.installer.exe'
  url64         = 'http://rm-eu.palemoon.org/release/palemoon-28.5.0.win64.installer.exe'

  softwareName  = 'Pale Moon*'

  checksum      = '7bb7c27c35a8073825d79827d5b135dbd2d0a65bad43d7e5f302edee739cc6d9'
  checksumType  = 'sha256'
  checksum64    = '0a5e38458b9d9b300bfbb39ae32e80e44a419ca53efa4dfe423f90da3e67faf8'
  checksumType64= 'sha256'

  silentArgs    = "/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-"
  validExitCodes= @(0)
}

Install-ChocolateyPackage @packageArgs
