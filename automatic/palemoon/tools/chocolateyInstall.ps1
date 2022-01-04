$ErrorActionPreference = 'Stop';

$packageArgs = @{
  packageName   = 'palemoon'
  fileType      = 'exe'
  url           = 'https://rm-eu.palemoon.org/release/palemoon-29.4.3.win32.installer.exe'
  url64         = 'https://rm-eu.palemoon.org/release/palemoon-29.4.3.win64.installer.exe'

  softwareName  = 'Pale Moon*'

  checksum      = '4307157eb7fb77fadaa9edaaf84b0665eb20938d39381edec2799125f77c27ea'
  checksumType  = 'sha256'
  checksum64    = '2870e715137289f17279618908056fcb59f62b851b6d5c80be076bdd71dd5ba5'
  checksumType64= 'sha256'

  silentArgs    = "/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-"
  validExitCodes= @(0)
}

Install-ChocolateyPackage @packageArgs
