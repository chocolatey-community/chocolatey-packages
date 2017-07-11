$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName    = 'reshack'
  fileType       = 'EXE'
  url            = 'http://www.angusj.com/resourcehacker/reshacker_setup.exe'
  checksum       = '32d9aa920d4d97e799fbb630f9bbc4597b52281692175688b6a582501eb0a683'
  checksumType   = 'sha256'
  silentArgs     = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART'
  validExitCodes = @(0)
  softwareName   = 'Resource Hacker*'
}
Install-ChocolateyPackage @packageArgs
