$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName            = '360ts'
  fileType               = 'exe'
  url                    = 'https://free.360totalsecurity.com/totalsecurity/360TS_Setup_10.2.0.1251.exe'
  checksum               = 'c43768c1104962650f1788dee0586695fba237cb4e400f09b737fb1d0824d095'
  checksumType           = 'sha256'
  silentArgs             = '/S'
  validExitCodes         = @(0)
  softwareName           = '360 Total Security'
}
Install-ChocolateyPackage @packageArgs
