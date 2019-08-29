$ErrorActionPreference = 'Stop';

$packageArgs = @{
  packageName   = 'palemoon'
  fileType      = 'exe'
  url           = 'https://rm-eu.palemoon.org/release/palemoon-28.7.0.win32.installer.exe'
  url64         = 'https://rm-eu.palemoon.org/release/palemoon-28.7.0.win64.installer.exe'

  softwareName  = 'Pale Moon*'

  checksum      = 'eb36493a1cdf2e4c92f1d80442a8ada02a97981e3a3491f084d4ed4b31a9819d'
  checksumType  = 'sha256'
  checksum64    = 'b7af7312336e1da9dce9a53fb81e6597fa634e7b991e5ea703fba9d62813b637'
  checksumType64= 'sha256'

  silentArgs    = "/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-"
  validExitCodes= @(0)
}

Install-ChocolateyPackage @packageArgs
