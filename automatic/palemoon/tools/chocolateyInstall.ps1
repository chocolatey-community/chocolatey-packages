$ErrorActionPreference = 'Stop';

$packageArgs = @{
  packageName   = 'palemoon'
  fileType      = 'exe'
  url           = 'https://rm-eu.palemoon.org/release/palemoon-33.8.1.win32.installer.exe'
  url64         = 'https://rm-eu.palemoon.org/release/palemoon-33.8.1.win64.installer.exe'

  softwareName  = 'Pale Moon*'

  checksum      = '880174f0525e8d63745fdd3f98ef2780f9ea6fdcc37f247844a38da3fec1c28f'
  checksumType  = 'sha256'
  checksum64    = '8491986e31c16641f7ba2c2b54745346a0991d2d64eea2f36668360f025edcfa'
  checksumType64= 'sha256'

  silentArgs    = "/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-"
  validExitCodes= @(0)
}

Install-ChocolateyPackage @packageArgs
