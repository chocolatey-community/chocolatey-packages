$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName            = 'mpc-hc'
  fileType               = 'exe'
  url                    = 'https://binaries.mpc-hc.org/MPC%20HomeCinema%20-%20Win32/MPC-HC_v1.7.10_x86/MPC-HC.1.7.10.x86.exe'
  url64bit               = 'https://binaries.mpc-hc.org/MPC%20HomeCinema%20-%20x64/MPC-HC_v1.7.10_x64/MPC-HC.1.7.10.x64.exe'
  checksum               = 'a00009fb70b3f8ab7675bad4c323d354bdb297bcbca44b690f7e18526c394dd6'
  checksum64             = 'ac93fcf3bb3f0c571f74fb6917d057a7c030143aac68cd53365355a188bc2edd'
  checksumType           = 'sha256'
  checksumType64         = 'sha256'
  silentArgs             = '/VERYSILENT'
  validExitCodes         = @(0)
  softwareName           = 'mpc-hc*'
}
Install-ChocolateyPackage @packageArgs
