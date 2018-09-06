$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName            = '360tse'
  fileType               = 'exe'
  url                    = 'https://free.360totalsecurity.com/totalsecurity/360TSE_Setup_8.8.0.1097.exe'
  checksum               = '8753617e0e890b563af883908f440fd7f9a88ec0e44b812792c4cd6e4931feac'
  checksumType           = 'sha256'
  silentArgs             = '/S'
  validExitCodes         = @(0)
  softwareName           = '360 Total Security Essential'
}
Install-ChocolateyPackage @packageArgs
