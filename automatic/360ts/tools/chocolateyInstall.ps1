$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName            = '360ts'
  fileType               = 'exe'
  url                    = 'https://free.360totalsecurity.com/totalsecurity/360TS_Setup_9.6.0.1283.exe'
  checksum               = '0ddb2b8e942c9cfeb9b7532d5982a38f6581b72cc812903f44b2f1ab1630a344'
  checksumType           = 'sha256'
  silentArgs             = '/S'
  validExitCodes         = @(0)
  softwareName           = '360 Total Security'
}
Install-ChocolateyPackage @packageArgs
