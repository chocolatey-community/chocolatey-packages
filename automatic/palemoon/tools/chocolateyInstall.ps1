$ErrorActionPreference = 'Stop';

$packageArgs = @{
  packageName   = 'palemoon'
  fileType      = 'exe'
  url           = 'https://rm-eu.palemoon.org/release/palemoon-34.3.0.1.win32.installer.exe'
  url64         = 'https://rm-eu.palemoon.org/release/palemoon-34.3.0.1.win64.installer.exe'

  softwareName  = 'Pale Moon*'

  checksum      = '9b46845b455378f889aa59912c601beacc3004003199a2a2c051f5b69003db86'
  checksumType  = 'sha256'
  checksum64    = '22c39b90bb71121f19ad6df54f84f66ff847b1a936db2379e9b24c6c8ff3ba71'
  checksumType64= 'sha256'

  silentArgs    = "/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-"
  validExitCodes= @(0)
}

Install-ChocolateyPackage @packageArgs
