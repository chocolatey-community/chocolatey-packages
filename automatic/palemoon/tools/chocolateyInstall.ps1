$ErrorActionPreference = 'Stop';

$packageArgs = @{
  packageName   = 'palemoon'
  fileType      = 'exe'
  url           = 'http://rm-eu.palemoon.org/release/palemoon-28.0.0.win32.installer.exe'
  url64         = 'http://rm-eu.palemoon.org/release/palemoon-28.0.0.win64.installer.exe'

  softwareName  = 'Pale Moon*'

  checksum      = '304aea11da1be04d23eae4e3352d8dc6537cb5256bd57e5659f3f90331ef0193'
  checksumType  = 'sha256'
  checksum64    = '02897b72c61355c8f861807d5ca9508128380eef1078323de214805208028662'
  checksumType64= 'sha256'

  silentArgs    = "/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-"
  validExitCodes= @(0)
}

Install-ChocolateyPackage @packageArgs
