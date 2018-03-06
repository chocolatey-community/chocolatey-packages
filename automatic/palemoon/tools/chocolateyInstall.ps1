$ErrorActionPreference = 'Stop';

$packageArgs = @{
  packageName   = 'palemoon'
  fileType      = 'exe'
  url           = 'http://rm-eu.palemoon.org/release/palemoon-27.8.1.win32.installer.exe'
  url64         = 'http://rm-eu.palemoon.org/release/palemoon-27.8.1.win64.installer.exe'

  softwareName  = 'Pale Moon*'

  checksum      = 'de079b2dab585ff28fa83e0b155944f76e1f2aea4b310c753a353d6d4421e413'
  checksumType  = 'sha256'
  checksum64    = '70e95efffaf75ee671e3290dae97288ac3f71dae220b13b2984f7920533b25f9'
  checksumType64= 'sha256'

  silentArgs    = "/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-"
  validExitCodes= @(0)
}

Install-ChocolateyPackage @packageArgs
