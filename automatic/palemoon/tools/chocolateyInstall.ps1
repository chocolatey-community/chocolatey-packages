$ErrorActionPreference = 'Stop';

$packageArgs = @{
  packageName   = 'palemoon'
  fileType      = 'exe'
  url           = 'https://rm-eu.palemoon.org/release/palemoon-32.0.0.win32.installer.exe'
  url64         = 'https://rm-eu.palemoon.org/release/palemoon-32.0.0.win64.installer.exe'

  softwareName  = 'Pale Moon*'

  checksum      = 'a3989e7b9a7271b2a86f58428ea331992ed3dba496e9f2294ff6ceb6317a5768'
  checksumType  = 'sha256'
  checksum64    = '3d52eacb78964316a6c12c737a6d7317f30cbc8754400f4c7e4256e656ac9a83'
  checksumType64= 'sha256'

  silentArgs    = "/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-"
  validExitCodes= @(0)
}

Install-ChocolateyPackage @packageArgs
