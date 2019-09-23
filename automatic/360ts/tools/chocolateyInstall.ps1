$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName            = '360tse'
  fileType               = 'exe'
  url                    = 'https://free.360totalsecurity.com/totalsecurity/360TSE_Setup_8.8.0.1116.exe'
  checksum               = '1c3c933712a9bffc4a27bfcdcdf4c4e95d2505d14ce8e95f8b33467a4199c6c4'
  checksumType           = 'sha256'
  silentArgs             = '/S'
  validExitCodes         = @(0)
  softwareName           = '360 Total Security Essential'
}
Install-ChocolateyPackage @packageArgs
