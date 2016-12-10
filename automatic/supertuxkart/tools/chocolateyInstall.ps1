$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName            = 'supertuxkart'
  fileType               = 'exe'
  url                    = 'https://sourceforge.net/projects/supertuxkart/files/SuperTuxKart/0.9.2/supertuxkart-0.9.2.exe/download'
  checksum               = 'd55e9af26d1adafc3432527925c54aa0e613b6111170caf9715ca65ed4c196a1'
  checksumType           = 'sha256'
  silentArgs             = '/S'
  validExitCodes         = @(0)
  softwareName           = 'supertuxkart*'
}
Install-ChocolateyPackage @packageArgs
