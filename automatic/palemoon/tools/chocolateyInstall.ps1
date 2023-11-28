$ErrorActionPreference = 'Stop';

$packageArgs = @{
  packageName   = 'palemoon'
  fileType      = 'exe'
  url           = 'https://rm-eu.palemoon.org/release/palemoon-32.5.1.win32.installer.exe'
  url64         = 'https://rm-eu.palemoon.org/release/palemoon-32.5.1.win64.installer.exe'

  softwareName  = 'Pale Moon*'

  checksum      = 'f662ab88e633f2f106b9b3cd27e431c3ba1c6a094f5651dea638a369f9a001ee'
  checksumType  = 'sha256'
  checksum64    = 'f0f975e9606127a7f0772f382027e81bda749e8cc0973cd84b347aec8321890c'
  checksumType64= 'sha256'

  silentArgs    = "/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-"
  validExitCodes= @(0)
}

Install-ChocolateyPackage @packageArgs
