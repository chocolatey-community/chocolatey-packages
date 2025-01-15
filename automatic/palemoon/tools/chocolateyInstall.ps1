$ErrorActionPreference = 'Stop';

$packageArgs = @{
  packageName   = 'palemoon'
  fileType      = 'exe'
  url           = 'https://rm-eu.palemoon.org/release/palemoon-33.5.1.win32.installer.exe'
  url64         = 'https://rm-eu.palemoon.org/release/palemoon-33.5.1.win64.installer.exe'

  softwareName  = 'Pale Moon*'

  checksum      = 'e6bad2af85b2bc7a397d584c7f17fd56b74cc30bc7517cd7979775dfe2696c7e'
  checksumType  = 'sha256'
  checksum64    = 'bd791523bec6c9a4cab56f59453fe8f150d99f3dc95d44e16766d9fc7ab35666'
  checksumType64= 'sha256'

  silentArgs    = "/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-"
  validExitCodes= @(0)
}

Install-ChocolateyPackage @packageArgs
