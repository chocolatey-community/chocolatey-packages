$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName            = '360ts'
  fileType               = 'exe'
  url                    = 'https://free.360totalsecurity.com/totalsecurity/360TS_Setup_10.8.0.1531.exe'
  checksum               = 'f3566d91f92fc0b531114c7e1072ed8d489eeca5c6c349790d9e3afe18750fe3'
  checksumType           = 'sha256'
  silentArgs             = '/S'
  validExitCodes         = @(0)
  softwareName           = '360 Total Security'
}
Install-ChocolateyPackage @packageArgs
