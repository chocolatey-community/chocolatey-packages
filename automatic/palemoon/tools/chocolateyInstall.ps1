$ErrorActionPreference = 'Stop';

$packageArgs = @{
  packageName   = 'palemoon'
  fileType      = 'exe'
  url           = 'https://rm-eu.palemoon.org/release/palemoon-33.6.0.win32.installer.exe'
  url64         = 'https://rm-eu.palemoon.org/release/palemoon-33.6.0.win64.installer.exe'

  softwareName  = 'Pale Moon*'

  checksum      = '1f8e1fd33641d9ef68fb2eaa43eb2dad11d8c7131127499fb23d80f081563182'
  checksumType  = 'sha256'
  checksum64    = '4433992b17ea73be31db0e57b53ce5e482baf9c140a79780f31ccd8c3b1bfd66'
  checksumType64= 'sha256'

  silentArgs    = "/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-"
  validExitCodes= @(0)
}

Install-ChocolateyPackage @packageArgs
