$ErrorActionPreference = 'Stop';

$packageArgs = @{
  packageName   = 'palemoon'
  fileType      = 'exe'
  url           = 'https://rm-eu.palemoon.org/release/palemoon-33.6.0.1.win32.installer.exe'
  url64         = 'https://rm-eu.palemoon.org/release/palemoon-33.6.0.1.win64.installer.exe'

  softwareName  = 'Pale Moon*'

  checksum      = '287052bd80bc73f2af7cdd153678a5dbf7a9bad9de6ec510b45e9e6ebb4da505'
  checksumType  = 'sha256'
  checksum64    = '2414659c561fda01c5e52efe6881dffef0b70e9c5e49595fe1eacd9b9f14f43c'
  checksumType64= 'sha256'

  silentArgs    = "/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-"
  validExitCodes= @(0)
}

Install-ChocolateyPackage @packageArgs
