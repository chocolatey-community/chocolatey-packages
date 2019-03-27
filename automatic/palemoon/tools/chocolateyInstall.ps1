$ErrorActionPreference = 'Stop';

$packageArgs = @{
  packageName   = 'palemoon'
  fileType      = 'exe'
  url           = 'http://rm-eu.palemoon.org/release/palemoon-28.4.1.win32.installer.exe'
  url64         = 'http://rm-eu.palemoon.org/release/palemoon-28.4.1.win64.installer.exe'

  softwareName  = 'Pale Moon*'

  checksum      = '79a8e1b1b147650bd48cb61132b72c7824a88b879d4447f54a489fe7d9320c0c'
  checksumType  = 'sha256'
  checksum64    = '749314bb3a6781f263d0a08ebb7bc9735963e7d6da3f459e77d0659bdef614e9'
  checksumType64= 'sha256'

  silentArgs    = "/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-"
  validExitCodes= @(0)
}

Install-ChocolateyPackage @packageArgs
