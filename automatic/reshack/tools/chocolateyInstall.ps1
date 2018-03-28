$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName    = 'reshack'
  fileType       = 'EXE'
  url            = 'http://www.angusj.com/resourcehacker/reshacker_setup.exe'
  checksum       = 'ee23ab3c5bc3a8a44956ea01e1df278b10427c491d3acc7d031aeb761ac29617'
  checksumType   = 'sha256'
  silentArgs     = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART'
  validExitCodes = @(0)
  softwareName   = 'Resource Hacker*'
}
Install-ChocolateyPackage @packageArgs
