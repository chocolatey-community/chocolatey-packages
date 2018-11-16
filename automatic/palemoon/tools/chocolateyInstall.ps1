$ErrorActionPreference = 'Stop';

$packageArgs = @{
  packageName   = 'palemoon'
  fileType      = 'exe'
  url           = 'http://rm-eu.palemoon.org/release/palemoon-28.2.1.win32.installer.exe'
  url64         = 'http://rm-eu.palemoon.org/release/palemoon-28.2.1.win64.installer.exe'

  softwareName  = 'Pale Moon*'

  checksum      = '910d8d063fe6c507758576dac2292b0611c506e5494825015e1e53bcb46a29dc'
  checksumType  = 'sha256'
  checksum64    = '603e7de38682bb1afbee8dd064be18e38ff163ff5dffdc9866f2b0ceb4d2c1a3'
  checksumType64= 'sha256'

  silentArgs    = "/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-"
  validExitCodes= @(0)
}

Install-ChocolateyPackage @packageArgs
