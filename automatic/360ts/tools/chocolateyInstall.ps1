$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName            = '360tse'
  fileType               = 'exe'
  url                    = 'https://free.360totalsecurity.com/totalsecurity/360TSE_Setup_8.8.0.1090.exe'
  checksum               = 'd475bfadc317b54de8aae8f83bc46b750a09e87ac3d51846f78b1747ff25f44d'
  checksumType           = 'sha256'
  silentArgs             = '/S'
  validExitCodes         = @(0)
  softwareName           = '360 Total Security Essential'
}
Install-ChocolateyPackage @packageArgs
