$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName            = '360tse'
  fileType               = 'exe'
  url                    = 'https://free.360totalsecurity.com/totalsecurity/360TSE_Setup_8.8.0.1114.exe'
  checksum               = '2654d5c7d38eaf007e9096187b0cd78a8a943963f69f0353a18391c9c883c0e9'
  checksumType           = 'sha256'
  silentArgs             = '/S'
  validExitCodes         = @(0)
  softwareName           = '360 Total Security Essential'
}
Install-ChocolateyPackage @packageArgs
