$ErrorActionPreference = 'Stop';

$packageArgs = @{
  packageName   = 'gnucash'
  fileType      = 'exe'
  url           = 'https://github.com/Gnucash/gnucash/releases/download/2.6.15/gnucash-2.6.15.setup.exe'

  softwareName  = 'GnuCash*'

  checksum      = '822d4c99e402cf9526c5ec1f2f246ded704eefd96185e7e18712ab06f12b00e9'
  checksumType  = 'sha256'

  silentArgs    = "/VERYSILENT /SUPPRESSMSGBOXES /SP-"
  validExitCodes= @(0)
}

Install-ChocolateyPackage @packageArgs
