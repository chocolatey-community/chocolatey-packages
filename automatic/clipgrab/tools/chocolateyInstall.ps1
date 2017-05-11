$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName            = 'clipgrab'
  fileType               = 'exe'
  url                    = 'https://download.clipgrab.org/clipgrab-3.6.5-cgde.exe'
  checksum               = 'f28ef377725c65061860ff9b16452a88f3b94429fbf5d4ee4c140663dbb1a59b'
  checksumType           = 'sha256'
  silentArgs             = '/VERYSILENT'
  validExitCodes         = @(0)
  softwareName           = 'clipgrab*'
}
Install-ChocolateyPackage @packageArgs
