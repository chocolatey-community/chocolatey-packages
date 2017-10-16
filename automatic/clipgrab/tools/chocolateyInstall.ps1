$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName            = 'clipgrab'
  fileType               = 'exe'
  url                    = 'https://download.clipgrab.org/clipgrab-3.6.6-cgde.exe'
  checksum               = '9b6438fa0d8a298661a95c0f11f8312530180e403db207ffbe469f78097c76c3'
  checksumType           = 'sha256'
  silentArgs             = '/VERYSILENT'
  validExitCodes         = @(0)
  softwareName           = 'clipgrab*'
}
Install-ChocolateyPackage @packageArgs
