$ErrorActionPreference = 'Stop';

$packageArgs = @{
  packageName   = 'palemoon'
  fileType      = 'exe'
  url           = 'https://rm-eu.palemoon.org/release/palemoon-28.14.2.win32.installer.exe'
  url64         = 'https://rm-eu.palemoon.org/release/palemoon-28.14.2.win64.installer.exe'

  softwareName  = 'Pale Moon*'

  checksum      = '1335fc7f0a329c3e8723041769fefb2583ecdd0c265f11cf0e1ee20792e61897'
  checksumType  = 'sha256'
  checksum64    = '9c1ef72b7d04a37ec5ff01dfca8b62c35b3b4f52ea323d3486f3a1a835549f92'
  checksumType64= 'sha256'

  silentArgs    = "/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-"
  validExitCodes= @(0)
}

Install-ChocolateyPackage @packageArgs
