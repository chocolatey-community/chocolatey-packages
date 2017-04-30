$ErrorActionPreference = 'Stop';

$packageArgs = @{
  packageName   = 'palemoon'
  fileType      = 'exe'
  url           = 'http://rm-eu.palemoon.org/release/palemoon-27.2.0.win32.installer.exe'
  url64         = 'http://rm-eu.palemoon.org/release/palemoon-27.2.0.win64.installer.exe'

  softwareName  = 'Pale Moon*'

  checksum      = '0caca3dd8fdf4810f2cecfd2df8e6afd9ac04370fe2f2d4ad392f3c4dd8c1a54'
  checksumType  = 'sha256'
  checksum64    = 'b5e0bb15a08046a7b46a5f378bef5bc077cb19c46c253d134afd402ebc694e87'
  checksumType64= 'sha256'

  silentArgs    = "/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-"
  validExitCodes= @(0)
}

Install-ChocolateyPackage @packageArgs
