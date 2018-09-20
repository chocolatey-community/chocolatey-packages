$ErrorActionPreference = 'Stop';

$packageArgs = @{
  packageName   = 'palemoon'
  fileType      = 'exe'
  url           = 'http://rm-eu.palemoon.org/release/palemoon-28.1.0.win32.installer.exe'
  url64         = 'http://rm-eu.palemoon.org/release/palemoon-28.1.0.win64.installer.exe'

  softwareName  = 'Pale Moon*'

  checksum      = 'bce7e80293b412c67796fb6f7a19868da48edb3dca6ff20377c4174ba3acc27a'
  checksumType  = 'sha256'
  checksum64    = 'a1db58e9cf5fdd240ceb94d692d47c243b384a427ca8b97304f457b19121bf04'
  checksumType64= 'sha256'

  silentArgs    = "/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-"
  validExitCodes= @(0)
}

Install-ChocolateyPackage @packageArgs
