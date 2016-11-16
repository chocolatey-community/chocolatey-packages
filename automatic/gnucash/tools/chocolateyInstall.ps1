$ErrorActionPreference = 'Stop';

$packageArgs = @{
  packageName   = 'gnucash'
  fileType      = 'exe'
  url           = ''

  softwareName  = 'GnuCash*'

  checksum      = ''
  checksumType  = 'sha256'

  silentArgs    = "/VERYSILENT /SUPPRESSMSGBOXES /SP-"
  validExitCodes= @(0)
}

Install-ChocolateyPackage @packageArgs
