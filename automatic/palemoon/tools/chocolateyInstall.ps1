$ErrorActionPreference = 'Stop';

$packageArgs = @{
  packageName   = 'palemoon'
  fileType      = 'exe'
  url           = 'https://rm-eu.palemoon.org/release/palemoon-31.1.1.win32.installer.exe'
  url64         = 'https://rm-eu.palemoon.org/release/palemoon-31.1.1.win64.installer.exe'

  softwareName  = 'Pale Moon*'

  checksum      = 'eb727f3012c58872c9dd4b0e67a3f4cbe37d536ad507ad43a74f781a5f8920fb'
  checksumType  = 'sha256'
  checksum64    = '4f67a44182286d9dd44c5629b35fa49c0d04ecf7fd356bda93bf18a5e627e576'
  checksumType64= 'sha256'

  silentArgs    = "/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-"
  validExitCodes= @(0)
}

Install-ChocolateyPackage @packageArgs
