$ErrorActionPreference = 'Stop';

$packageArgs = @{
  packageName   = 'palemoon'
  fileType      = 'exe'
  url           = 'https://rm-eu.palemoon.org/release/palemoon-33.9.1.win32.installer.exe'
  url64         = 'https://rm-eu.palemoon.org/release/palemoon-33.9.1.win64.installer.exe'

  softwareName  = 'Pale Moon*'

  checksum      = '5d1fd293db861698b37cb6906f53bb7234ff061df267bb87da2cb8200409ffdb'
  checksumType  = 'sha256'
  checksum64    = 'ddb26b85f604052fc267a4891b888d21926b32e3873243b1162c56afee71936f'
  checksumType64= 'sha256'

  silentArgs    = "/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-"
  validExitCodes= @(0)
}

Install-ChocolateyPackage @packageArgs
