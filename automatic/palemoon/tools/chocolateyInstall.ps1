$ErrorActionPreference = 'Stop';

$packageArgs = @{
  packageName   = 'palemoon'
  fileType      = 'exe'
  url           = 'http://rm-eu.palemoon.org/release/palemoon-28.3.1.win32.installer.exe'
  url64         = 'http://rm-eu.palemoon.org/release/palemoon-28.3.1.win64.installer.exe'

  softwareName  = 'Pale Moon*'

  checksum      = '000a4efa1380ed15dcd520d682dde338363b82bfebf31b7200b5d9b2be0ee95b'
  checksumType  = 'sha256'
  checksum64    = 'ec5857642c4aac9287173ba57455871f9731d890647dfcf7468e6b12a7077943'
  checksumType64= 'sha256'

  silentArgs    = "/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-"
  validExitCodes= @(0)
}

Install-ChocolateyPackage @packageArgs
