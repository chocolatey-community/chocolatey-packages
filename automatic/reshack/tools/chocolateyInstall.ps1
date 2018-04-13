$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName    = 'reshack'
  fileType       = 'EXE'
  url            = 'http://www.angusj.com/resourcehacker/reshacker_setup.exe'
  checksum       = 'efcb750e5d1d6996f0f96040e94511acb6459077dbe6d505c6c603046002bb56'
  checksumType   = 'sha256'
  silentArgs     = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART'
  validExitCodes = @(0)
  softwareName   = 'Resource Hacker*'
}
Install-ChocolateyPackage @packageArgs
