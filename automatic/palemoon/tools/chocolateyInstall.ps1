$ErrorActionPreference = 'Stop';

$packageArgs = @{
  packageName   = 'palemoon'
  fileType      = 'exe'
  url           = 'https://rm-eu.palemoon.org/release/palemoon-28.8.0.win32.installer.exe'
  url64         = 'https://rm-eu.palemoon.org/release/palemoon-28.8.0.win64.installer.exe'

  softwareName  = 'Pale Moon*'

  checksum      = '53cb9d643fbbdf9773323b82b45c0131c233c23c6f30d2ba3f45ac1fd94b0e57'
  checksumType  = 'sha256'
  checksum64    = 'f9da4c3ed515d42b14132fc4b700a5c42f7a25116cf23dd7207154b4e6531358'
  checksumType64= 'sha256'

  silentArgs    = "/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-"
  validExitCodes= @(0)
}

Install-ChocolateyPackage @packageArgs
