$ErrorActionPreference = 'Stop';

$packageArgs = @{
  packageName   = 'palemoon'
  fileType      = 'exe'
  url           = 'http://rm-eu.palemoon.org/release/palemoon-27.4.0.win32.installer.exe'
  url64         = 'http://rm-eu.palemoon.org/release/palemoon-27.4.0.win64.installer.exe'

  softwareName  = 'Pale Moon*'

  checksum      = 'd9ccbad7ffb3be01dc0eb42c411fdc39133a93dcd618ea9bc5eb342afc777e5f'
  checksumType  = 'sha256'
  checksum64    = '4cb87d5bfec84562af4136dd05a8d96b2ee3d7962be690cc560993e1e8c0def4'
  checksumType64= 'sha256'

  silentArgs    = "/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-"
  validExitCodes= @(0)
}

Install-ChocolateyPackage @packageArgs
