$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName            = '360ts'
  fileType               = 'exe'
  url                    = 'http://int.down.360safe.com/totalsecurity/360TS_Setup.exe'
  checksum               = 'cce663b3a4086543c6f398f226f6e861bf827ea85170c1ee9d1ab7233d49b0ea'
  checksumType           = 'sha256'
  silentArgs             = '/S'
  validExitCodes         = @(0)
  softwareName           = '360 Total Security'
}
Install-ChocolateyPackage @packageArgs
