$ErrorActionPreference = 'Stop';

$packageArgs = @{
  packageName   = 'palemoon'
  fileType      = 'exe'
  url           = 'https://rm-eu.palemoon.org/release/palemoon-29.2.0.win32.installer.exe'
  url64         = 'https://rm-eu.palemoon.org/release/palemoon-29.2.0.win64.installer.exe'

  softwareName  = 'Pale Moon*'

  checksum      = 'b88f7e04b23f565822e7d8cfd3239a65cebd5c003e6e91a67620ff6574f663cd'
  checksumType  = 'sha256'
  checksum64    = 'f3714768041fa46b14bc2f4ae34f48678f1abc26537a0e3d72ccb26edca8b914'
  checksumType64= 'sha256'

  silentArgs    = "/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-"
  validExitCodes= @(0)
}

Install-ChocolateyPackage @packageArgs
