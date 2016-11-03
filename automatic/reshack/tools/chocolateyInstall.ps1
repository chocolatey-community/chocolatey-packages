$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName    = 'reshack'
  fileType       = 'EXE'
  url            = ''
  checksum       = ''
  checksumType   = 'sha256'
  silentArgs     = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART'
  validExitCodes = @(0)
  softwareName   = 'Resource Hacker*'
}
Install-ChocolateyPackage @packageArgs
