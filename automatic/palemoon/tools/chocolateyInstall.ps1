$ErrorActionPreference = 'Stop';

$packageArgs = @{
  packageName   = 'palemoon'
  fileType      = 'exe'
  url           = 'https://rm-eu.palemoon.org/release/palemoon-31.2.0.1.win32.installer.exe'
  url64         = 'https://rm-eu.palemoon.org/release/palemoon-31.2.0.1.win64.installer.exe'

  softwareName  = 'Pale Moon*'

  checksum      = 'd9220c8a8262cb1a7dad3060e30a69c0af7f59cf00da4244e63e1de274406a96'
  checksumType  = 'sha256'
  checksum64    = '35aae95e609e7e693498a5809b0d7baa399ec2c2508f3ed396e5d773f137bc52'
  checksumType64= 'sha256'

  silentArgs    = "/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-"
  validExitCodes= @(0)
}

Install-ChocolateyPackage @packageArgs
