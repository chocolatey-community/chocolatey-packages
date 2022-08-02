$ErrorActionPreference = 'Stop';

$packageArgs = @{
  packageName   = 'palemoon'
  fileType      = 'exe'
  url           = 'https://rm-eu.palemoon.org/release/palemoon-31.2.0.win32.installer.exe'
  url64         = 'https://rm-eu.palemoon.org/release/palemoon-31.2.0.win64.installer.exe'

  softwareName  = 'Pale Moon*'

  checksum      = 'ae2662796c286e8498a49f052b8ff9ab2448e28e268aad3ecaae147cac4f28bc'
  checksumType  = 'sha256'
  checksum64    = '3f1c728932019cb56ec3fb8857e0aa0042bf8299329c784d97ad3263169ffe7d'
  checksumType64= 'sha256'

  silentArgs    = "/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-"
  validExitCodes= @(0)
}

Install-ChocolateyPackage @packageArgs
