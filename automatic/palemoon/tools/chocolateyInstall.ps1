$ErrorActionPreference = 'Stop';

$packageArgs = @{
  packageName   = 'palemoon'
  fileType      = 'exe'
  url           = 'https://rm-eu.palemoon.org/release/palemoon-33.2.1.win32.installer.exe'
  url64         = 'https://rm-eu.palemoon.org/release/palemoon-33.2.1.win64.installer.exe'

  softwareName  = 'Pale Moon*'

  checksum      = '2367d67d53915acd52b8f8e50e2dcb4c791e7210a15fd755438704ecf2beed9c'
  checksumType  = 'sha256'
  checksum64    = 'b4cd50b3c47283e141a9c70e918ec3957a7b9c20450153a5c6e4658909d02e93'
  checksumType64= 'sha256'

  silentArgs    = "/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-"
  validExitCodes= @(0)
}

Install-ChocolateyPackage @packageArgs
