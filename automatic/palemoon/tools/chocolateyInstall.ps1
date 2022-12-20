$ErrorActionPreference = 'Stop';

$packageArgs = @{
  packageName   = 'palemoon'
  fileType      = 'exe'
  url           = 'https://rm-eu.palemoon.org/release/palemoon-31.4.2.win32.installer.exe'
  url64         = 'https://rm-eu.palemoon.org/release/palemoon-31.4.2.win64.installer.exe'

  softwareName  = 'Pale Moon*'

  checksum      = '00bedceb5971fe70e7b63df8ed0a1e7f2781d03fcccc7e427bcda25cc1990dcd'
  checksumType  = 'sha256'
  checksum64    = '2b94a79b927851377090ccb8f729f9bdfad3f21b6caa54341708637608fc9ab8'
  checksumType64= 'sha256'

  silentArgs    = "/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-"
  validExitCodes= @(0)
}

Install-ChocolateyPackage @packageArgs
