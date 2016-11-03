$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName    = 'reshack'
  fileType       = 'EXE'
  url            = 'http://www.angusj.com/resourcehacker/reshacker_setup.exe'
  checksum       = '2505464f8229c1eed63d0c7c316bf2777a4f670c825975bf03c0321fe783f894'
  checksumType   = 'sha256'
  silentArgs     = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART'
  validExitCodes = @(0)
  softwareName   = 'Resource Hacker*'
}
Install-ChocolateyPackage @packageArgs
