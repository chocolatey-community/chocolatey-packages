$ErrorActionPreference = 'Stop';

$packageArgs = @{
  packageName   = 'palemoon'
  fileType      = 'exe'
  url           = 'https://rm-eu.palemoon.org/release/palemoon-32.2.0.win32.installer.exe'
  url64         = 'https://rm-eu.palemoon.org/release/palemoon-32.2.0.win64.installer.exe'

  softwareName  = 'Pale Moon*'

  checksum      = '27ba42ce0b77c1d2971ccb228de3cfb119f897a9fa623b9bb297e5a5d70af046'
  checksumType  = 'sha256'
  checksum64    = 'fc997eec917d784666f4ef306923fdf74c5662d444c62620fabf971f6241ded5'
  checksumType64= 'sha256'

  silentArgs    = "/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-"
  validExitCodes= @(0)
}

Install-ChocolateyPackage @packageArgs
