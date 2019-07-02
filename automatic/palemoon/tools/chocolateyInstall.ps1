$ErrorActionPreference = 'Stop';

$packageArgs = @{
  packageName   = 'palemoon'
  fileType      = 'exe'
  url           = 'http://rm-eu.palemoon.org/release/palemoon-28.6.0.win32.installer.exe'
  url64         = 'http://rm-eu.palemoon.org/release/palemoon-28.6.0.win64.installer.exe'

  softwareName  = 'Pale Moon*'

  checksum      = 'b1987fe3f2c8ef1c79a9fab0227e3a2c6cbff4d3b2e19261b46356fcd67cf079'
  checksumType  = 'sha256'
  checksum64    = 'e0117d8f353e1cf10043593b9e45abe458e7572b6417a5f8eb64789712957ac3'
  checksumType64= 'sha256'

  silentArgs    = "/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-"
  validExitCodes= @(0)
}

Install-ChocolateyPackage @packageArgs
