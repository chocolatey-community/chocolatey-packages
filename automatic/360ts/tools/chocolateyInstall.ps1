$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName            = '360tse'
  fileType               = 'exe'
  url                    = 'https://free.360totalsecurity.com/totalsecurity/360TSE_Setup_8.8.0.1101.exe'
  checksum               = '49a00c9e021cec26eb04ead5e8940b07fedb60ff0d54c7a5de5b46b25c7ce6d3'
  checksumType           = 'sha256'
  silentArgs             = '/S'
  validExitCodes         = @(0)
  softwareName           = '360 Total Security Essential'
}
Install-ChocolateyPackage @packageArgs
