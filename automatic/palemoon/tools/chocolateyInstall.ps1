$ErrorActionPreference = 'Stop';

$packageArgs = @{
  packageName   = 'palemoon'
  fileType      = 'exe'
  url           = 'https://rm-eu.palemoon.org/release/palemoon-29.4.2.win32.installer.exe'
  url64         = 'https://rm-eu.palemoon.org/release/palemoon-29.4.2.win64.installer.exe'

  softwareName  = 'Pale Moon*'

  checksum      = 'c2a5c034088eb013ad2bc46c17331f2fc2f3debbc35e1354d793eb5f730fe6c5'
  checksumType  = 'sha256'
  checksum64    = 'dabbde0d26c7e0fde1181e8acddb426e532ea076b13cd4819c9047139745e33e'
  checksumType64= 'sha256'

  silentArgs    = "/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-"
  validExitCodes= @(0)
}

Install-ChocolateyPackage @packageArgs
