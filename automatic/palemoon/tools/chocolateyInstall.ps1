$ErrorActionPreference = 'Stop';

$packageArgs = @{
  packageName   = 'palemoon'
  fileType      = 'exe'
  url           = 'https://rm-eu.palemoon.org/release/palemoon-34.1.0.win32.installer.exe'
  url64         = 'https://rm-eu.palemoon.org/release/palemoon-34.1.0.win64.installer.exe'

  softwareName  = 'Pale Moon*'

  checksum      = '4351738eba98107893f4c09fefb753a03eb196cba23dba9a57b8a7fe4e3acc45'
  checksumType  = 'sha256'
  checksum64    = '2154b4feb8284a4e42d88b7611efa833250d5bc3914c07783fa9a82d488d73d9'
  checksumType64= 'sha256'

  silentArgs    = "/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-"
  validExitCodes= @(0)
}

Install-ChocolateyPackage @packageArgs
