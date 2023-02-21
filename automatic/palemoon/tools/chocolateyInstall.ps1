$ErrorActionPreference = 'Stop';

$packageArgs = @{
  packageName   = 'palemoon'
  fileType      = 'exe'
  url           = 'https://rm-eu.palemoon.org/release/palemoon-32.0.1.win32.installer.exe'
  url64         = 'https://rm-eu.palemoon.org/release/palemoon-32.0.1.win64.installer.exe'

  softwareName  = 'Pale Moon*'

  checksum      = 'c81177e3032bc5d37251c78675a2dbb80bc91b5846149bed245caedcc275ab7e'
  checksumType  = 'sha256'
  checksum64    = 'c824b5be4e3a5bb5984fcd967286a6fddad5ba5e4f956247d44d186bd111904c'
  checksumType64= 'sha256'

  silentArgs    = "/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-"
  validExitCodes= @(0)
}

Install-ChocolateyPackage @packageArgs
