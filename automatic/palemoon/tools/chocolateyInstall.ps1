$ErrorActionPreference = 'Stop';

$packageArgs = @{
  packageName   = 'palemoon'
  fileType      = 'exe'
  url           = 'https://rm-eu.palemoon.org/release/palemoon-33.7.0.win32.installer.exe'
  url64         = 'https://rm-eu.palemoon.org/release/palemoon-33.7.0.win64.installer.exe'

  softwareName  = 'Pale Moon*'

  checksum      = '23254a109bdd7e9a3890a2a78763bc575d9e335b6e4552c574ea9441e02be4c6'
  checksumType  = 'sha256'
  checksum64    = '7ea0c87e29da64677f217348f1dc2c35a440704f101b726656427107d639cd0e'
  checksumType64= 'sha256'

  silentArgs    = "/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-"
  validExitCodes= @(0)
}

Install-ChocolateyPackage @packageArgs
