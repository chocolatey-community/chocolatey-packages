$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName            = 'fiddler4'
  fileType               = 'EXE'
  url                    = ''
  checksum               = ''
  checksumType           = 'sha256'
  silentArgs             = '/S'
  validExitCodes         = @(0)
  softwareName           = 'fiddler*'
}
Install-ChocolateyPackage @packageArgs
