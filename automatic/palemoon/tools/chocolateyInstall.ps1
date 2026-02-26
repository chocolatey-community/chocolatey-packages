$ErrorActionPreference = 'Stop';

$packageArgs = @{
  packageName   = 'palemoon'
  fileType      = 'exe'
  url           = 'https://rm-eu.palemoon.org/release/palemoon-34.0.1.win32.installer.exe'
  url64         = 'https://rm-eu.palemoon.org/release/palemoon-34.0.1.win64.installer.exe'

  softwareName  = 'Pale Moon*'

  checksum      = '2e0aa613a9939f0546eb5113b04578fbbe87d1226b7dbe8fe1e1ca839cfb5e3f'
  checksumType  = 'sha256'
  checksum64    = '0ba74fe20822b714b60e0b781a3b5252833c98f95e93a7552099cd7b71c95f1b'
  checksumType64= 'sha256'

  silentArgs    = "/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-"
  validExitCodes= @(0)
}

Install-ChocolateyPackage @packageArgs
