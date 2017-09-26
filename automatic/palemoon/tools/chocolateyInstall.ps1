$ErrorActionPreference = 'Stop';

$packageArgs = @{
  packageName   = 'palemoon'
  fileType      = 'exe'
  url           = 'http://rm-eu.palemoon.org/release/palemoon-27.5.0.win32.installer.exe'
  url64         = 'http://rm-eu.palemoon.org/release/palemoon-27.5.0.win64.installer.exe'

  softwareName  = 'Pale Moon*'

  checksum      = '8bbb3910142b573d09a2118c87ea4dfa48fc20359161299095175ff361d7bdad'
  checksumType  = 'sha256'
  checksum64    = 'de0aa484e5505ef783bd696fc7cbd00f7d8913a30bac45014d2528103d842ff1'
  checksumType64= 'sha256'

  silentArgs    = "/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-"
  validExitCodes= @(0)
}

Install-ChocolateyPackage @packageArgs
