$ErrorActionPreference = 'Stop';

$packageArgs = @{
  packageName   = 'palemoon'
  fileType      = 'exe'
  url           = 'https://rm-eu.palemoon.org/release/palemoon-32.3.0.win32.installer.exe'
  url64         = 'https://rm-eu.palemoon.org/release/palemoon-32.3.0.win64.installer.exe'

  softwareName  = 'Pale Moon*'

  checksum      = '07ede1b8f21be171667149c90afd78029bb0a1d0d2172df8bb03ee8c2d0e4d19'
  checksumType  = 'sha256'
  checksum64    = '8672953c76f72a41ea6cc945973067c05b68c571651eab31ac394b201cf1868a'
  checksumType64= 'sha256'

  silentArgs    = "/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-"
  validExitCodes= @(0)
}

Install-ChocolateyPackage @packageArgs
