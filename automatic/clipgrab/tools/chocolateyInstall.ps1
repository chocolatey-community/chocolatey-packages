$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName            = 'clipgrab'
  fileType               = 'exe'
  url                    = 'https://download.clipgrab.org/clipgrab-3.6.3-cgde.exe'
  checksum               = 'c23b69c26c18a55d6b825927bb374c8b3aae5a1298b28894e94b1376f78ee8e3'
  checksumType           = 'sha256'
  silentArgs             = '/VERYSILENT'
  validExitCodes         = @(0)
  softwareName           = 'clipgrab*'
}
Install-ChocolateyPackage @packageArgs
