$ErrorActionPreference = 'Stop';

$packageArgs = @{
  packageName   = 'palemoon'
  fileType      = 'exe'
  url           = 'http://rm-eu.palemoon.org/release/palemoon-28.5.2.win32.installer.exe'
  url64         = 'http://rm-eu.palemoon.org/release/palemoon-28.5.2.win64.installer.exe'

  softwareName  = 'Pale Moon*'

  checksum      = '8022ca6de796e394467e8d9b374370a2d2619da4814e601f9d0f8fd74c239400'
  checksumType  = 'sha256'
  checksum64    = 'cbfea82db33b0bbb107e7b119388147f66fb1b31b310302053c6ef8a9d3ffaaf'
  checksumType64= 'sha256'

  silentArgs    = "/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-"
  validExitCodes= @(0)
}

Install-ChocolateyPackage @packageArgs
