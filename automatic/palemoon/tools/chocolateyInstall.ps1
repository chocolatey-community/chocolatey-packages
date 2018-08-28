$ErrorActionPreference = 'Stop';

$packageArgs = @{
  packageName   = 'palemoon'
  fileType      = 'exe'
  url           = 'http://rm-eu.palemoon.org/release/palemoon-28.0.0.1.win32.installer.exe'
  url64         = 'http://rm-eu.palemoon.org/release/palemoon-28.0.0.1.win64.installer.exe'

  softwareName  = 'Pale Moon*'

  checksum      = '902e3c1304d4a054bf0c3b17656073ae29f4bb57dfe1bfa75428b196718c6b9f'
  checksumType  = 'sha256'
  checksum64    = '622bca8e3ea76a32982c574b15702d1c67c49af11df00d1279daf4c7dccc41f3'
  checksumType64= 'sha256'

  silentArgs    = "/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-"
  validExitCodes= @(0)
}

Install-ChocolateyPackage @packageArgs
