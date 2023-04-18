$ErrorActionPreference = 'Stop';

$packageArgs = @{
  packageName   = 'palemoon'
  fileType      = 'exe'
  url           = 'https://rm-eu.palemoon.org/release/palemoon-32.1.1.win32.installer.exe'
  url64         = 'https://rm-eu.palemoon.org/release/palemoon-32.1.1.win64.installer.exe'

  softwareName  = 'Pale Moon*'

  checksum      = '127b11e55c236112eed552c79ea61da3c6307c6c105e023b75aebeac90d5e478'
  checksumType  = 'sha256'
  checksum64    = 'e4dd3b9821bfe1002f28a4977affec54f7f02809ecb637aeac1ca36a82daaed8'
  checksumType64= 'sha256'

  silentArgs    = "/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-"
  validExitCodes= @(0)
}

Install-ChocolateyPackage @packageArgs
