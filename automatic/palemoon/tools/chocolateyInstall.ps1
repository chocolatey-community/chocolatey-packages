$ErrorActionPreference = 'Stop';

$packageArgs = @{
  packageName   = 'palemoon'
  fileType      = 'exe'
  url           = 'https://rm-eu.palemoon.org/release/palemoon-33.9.0.1.win32.installer.exe'
  url64         = 'https://rm-eu.palemoon.org/release/palemoon-33.9.0.1.win64.installer.exe'

  softwareName  = 'Pale Moon*'

  checksum      = '46a891966b7415d782f8d2242e3171483f287f11e289d202ec47f335cd8a0a55'
  checksumType  = 'sha256'
  checksum64    = 'b7d6df514686f78058bfad19fe65b57de0c9f192bf772eb1d94327f4d36f5f3d'
  checksumType64= 'sha256'

  silentArgs    = "/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-"
  validExitCodes= @(0)
}

Install-ChocolateyPackage @packageArgs
