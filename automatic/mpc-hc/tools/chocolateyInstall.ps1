$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName            = 'mpc-hc'
  fileType               = 'exe'
  url                    = 'https://binaries.mpc-hc.org/MPC%20HomeCinema%20-%20Win32/MPC-HC_v1.7.13_x86/MPC-HC.1.7.13.x86.exe'
  url64bit               = 'https://binaries.mpc-hc.org/MPC%20HomeCinema%20-%20x64/MPC-HC_v1.7.13_x64/MPC-HC.1.7.13.x64.exe'
  checksum               = 'ba6f1f617e9c4d3ce535a85c2fcda39e66fc13781f4cf6197fe802994d71f0ec'
  checksum64             = 'f84b347c75f650bff85c855b170ddb86ec72f025e6c7769387f2c999efd09d32'
  checksumType           = 'sha256'
  checksumType64         = 'sha256'
  silentArgs             = '/VERYSILENT'
  validExitCodes         = @(0)
  softwareName           = 'mpc-hc*'
}
Install-ChocolateyPackage @packageArgs
