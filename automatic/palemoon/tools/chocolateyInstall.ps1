$ErrorActionPreference = 'Stop';

$packageArgs = @{
  packageName   = 'palemoon'
  fileType      = 'exe'
  url           = 'https://rm-eu.palemoon.org/release/palemoon-33.0.2.win32.installer.exe'
  url64         = 'https://rm-eu.palemoon.org/release/palemoon-33.0.2.win64.installer.exe'

  softwareName  = 'Pale Moon*'

  checksum      = '11296025abf7182f8b4218b6a5b4d64023c71ed90de208362acd1e555a2dfbb3'
  checksumType  = 'sha256'
  checksum64    = '295129f2b08314cb6966fdc37f56b0642c0b82912a1e07d71a0c5afdf95d15b9'
  checksumType64= 'sha256'

  silentArgs    = "/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-"
  validExitCodes= @(0)
}

Install-ChocolateyPackage @packageArgs
