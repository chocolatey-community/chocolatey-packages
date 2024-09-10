$ErrorActionPreference = 'Stop';

$packageArgs = @{
  packageName   = 'palemoon'
  fileType      = 'exe'
  url           = 'https://rm-eu.palemoon.org/release/palemoon-33.3.1.win32.installer.exe'
  url64         = 'https://rm-eu.palemoon.org/release/palemoon-33.3.1.win64.installer.exe'

  softwareName  = 'Pale Moon*'

  checksum      = '4eda184caf1534bd7fcd6122daa99ef5b0fe70692279cd0bc773e790e8a0fc52'
  checksumType  = 'sha256'
  checksum64    = 'e460c747fa6c0106289815df00519e81d079a65f3d3c547544e331b97188052a'
  checksumType64= 'sha256'

  silentArgs    = "/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-"
  validExitCodes= @(0)
}

Install-ChocolateyPackage @packageArgs
