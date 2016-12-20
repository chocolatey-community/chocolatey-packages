$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName    = 'reshack'
  fileType       = 'EXE'
  url            = 'http://www.angusj.com/resourcehacker/reshacker_setup.exe'
  checksum       = '7c5e6a7158217ec3e3b1706608476ce7aa7028317399deae9a02bb87aaf8aa69'
  checksumType   = 'sha256'
  silentArgs     = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART'
  validExitCodes = @(0)
  softwareName   = 'Resource Hacker*'
}
Install-ChocolateyPackage @packageArgs
