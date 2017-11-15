$ErrorActionPreference = 'Stop';

$packageArgs = @{
  packageName   = 'palemoon'
  fileType      = 'exe'
  url           = 'http://rm-eu.palemoon.org/release/palemoon-27.6.1.win32.installer.exe'
  url64         = 'http://rm-eu.palemoon.org/release/palemoon-27.6.1.win64.installer.exe'

  softwareName  = 'Pale Moon*'

  checksum      = 'c6722da37f8fe062d11c93d8dc108faee7b1b34cf8abd778dc8858dbe5ccc651'
  checksumType  = 'sha256'
  checksum64    = '2bb5a977a8f0999ae052718129544ba61835d49d257f989afca309a36a70c2d9'
  checksumType64= 'sha256'

  silentArgs    = "/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-"
  validExitCodes= @(0)
}

Install-ChocolateyPackage @packageArgs
