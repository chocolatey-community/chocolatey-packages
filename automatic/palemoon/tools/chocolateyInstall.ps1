$ErrorActionPreference = 'Stop';

$packageArgs = @{
  packageName   = 'palemoon'
  fileType      = 'exe'
  url           = 'https://rm-eu.palemoon.org/release/palemoon-32.2.1.win32.installer.exe'
  url64         = 'https://rm-eu.palemoon.org/release/palemoon-32.2.1.win64.installer.exe'

  softwareName  = 'Pale Moon*'

  checksum      = '3ca1ec1bdd8b5fbf0caa6e30e4306a6f3496db69426e94f22265b7c60331b57b'
  checksumType  = 'sha256'
  checksum64    = 'c0cd395e824ed31c75146d1e39891cb1c39571331a7c1ed2bcfd7cb00710084a'
  checksumType64= 'sha256'

  silentArgs    = "/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-"
  validExitCodes= @(0)
}

Install-ChocolateyPackage @packageArgs
