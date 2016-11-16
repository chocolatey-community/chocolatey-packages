$ErrorActionPreference = 'Stop';

$packageArgs = @{
  packageName   = 'gnucash'
  fileType      = 'exe'
  url           = 'https://github.com/Gnucash/gnucash/releases/download/2.6.14a/gnucash-2.6.14-setup.exe'

  softwareName  = 'GnuCash*'

  checksum      = 'c0b71a6839df4fa17bf57d9a3c6fb104c8c456f80f1871cb3c842d6623ee868a'
  checksumType  = 'sha256'

  silentArgs    = "/VERYSILENT /SUPPRESSMSGBOXES /SP-"
  validExitCodes= @(0)
}

Install-ChocolateyPackage @packageArgs
