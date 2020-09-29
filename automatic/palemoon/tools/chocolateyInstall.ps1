$ErrorActionPreference = 'Stop';

$packageArgs = @{
  packageName   = 'palemoon'
  fileType      = 'exe'
  url           = 'https://rm-eu.palemoon.org/release/palemoon-28.14.0.win32.installer.exe'
  url64         = 'https://rm-eu.palemoon.org/release/palemoon-28.14.0.win64.installer.exe'

  softwareName  = 'Pale Moon*'

  checksum      = '0f8e54cd8fddf3d67ea4c9fc9c7f1c37f3f2f38e076ccc95b7533032aa3d7212'
  checksumType  = 'sha256'
  checksum64    = 'da1bbbe930db19965878afee424db8923c97ceff7dbc3bfb1083dca99b486efd'
  checksumType64= 'sha256'

  silentArgs    = "/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-"
  validExitCodes= @(0)
}

Install-ChocolateyPackage @packageArgs
