$ErrorActionPreference = 'Stop';

$packageArgs = @{
  packageName   = 'gnucash'
  fileType      = 'exe'
  url           = 'https://github.com/Gnucash/gnucash/releases/download/2.6.16/gnucash-2.6.16-1.setup.exe'

  softwareName  = 'GnuCash*'

  checksum      = 'db0e2f8e020d4e33a40b819456022b791ad23cc541b29f619914c3f97d786d80'
  checksumType  = 'sha256'

  silentArgs    = "/VERYSILENT /SUPPRESSMSGBOXES /SP-"
  validExitCodes= @(0)
}

Install-ChocolateyPackage @packageArgs
