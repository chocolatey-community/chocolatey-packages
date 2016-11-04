$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName    = 'bluegriffon'
  fileType       = 'exe'
  softwareName   = 'BlueGriffon*'

  checksum       = ''
  checksumType   = ''
  url            = ''

  silentArgs     = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-'
  validExitCodes = @(0)
}

Install-ChocolateyPackage @packageArgs
