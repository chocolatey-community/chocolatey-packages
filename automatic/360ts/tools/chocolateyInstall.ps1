$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName            = '360ts'
  fileType               = 'exe'
  url                    = 'https://free.360totalsecurity.com/totalsecurity/360TS_Setup_9.0.0.1168.exe'
  checksum               = '845f5a1838e34f604804aaa5d0ff8eff53c09a088d862faade3ae47d254b0a6f'
  checksumType           = 'sha256'
  silentArgs             = '/S'
  validExitCodes         = @(0)
  softwareName           = '360 Total Security'
}
Install-ChocolateyPackage @packageArgs
