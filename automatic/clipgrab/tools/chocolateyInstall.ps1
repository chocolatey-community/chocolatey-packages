$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName            = 'clipgrab'
  fileType               = 'exe'
  url                    = 'https://download.clipgrab.org/clipgrab-3.6.4-cgde.exe'
  checksum               = '12c2d25eaccb6e82c71e2b814cd565b6d7bb6a706c48afcc31fb7cd3267f5cca'
  checksumType           = 'sha256'
  silentArgs             = '/VERYSILENT'
  validExitCodes         = @(0)
  softwareName           = 'clipgrab*'
}
Install-ChocolateyPackage @packageArgs
