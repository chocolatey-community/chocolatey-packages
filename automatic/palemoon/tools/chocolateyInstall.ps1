$ErrorActionPreference = 'Stop';

$packageArgs = @{
  packageName   = 'palemoon'
  fileType      = 'exe'
  url           = 'http://rm-eu.palemoon.org/release/palemoon-27.4.1.win32.installer.exe'
  url64         = 'http://rm-eu.palemoon.org/release/palemoon-27.4.1.win64.installer.exe'

  softwareName  = 'Pale Moon*'

  checksum      = '37a37f0999ad22dafbdf7f7dbf0199b6e60f689df4029bf9ded4950af0af6cd5'
  checksumType  = 'sha256'
  checksum64    = '3d6db4441723a1e3471fb00eba814837a7017372b188ad7b37a0601134fa77a3'
  checksumType64= 'sha256'

  silentArgs    = "/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-"
  validExitCodes= @(0)
}

Install-ChocolateyPackage @packageArgs
