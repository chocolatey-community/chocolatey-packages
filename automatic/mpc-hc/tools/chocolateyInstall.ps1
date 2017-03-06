$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName            = 'mpc-hc'
  fileType               = 'exe'
  url                    = 'https://binaries.mpc-hc.org/MPC%20HomeCinema%20-%20Win32/MPC-HC_v1.7.11_x86/MPC-HC.1.7.11.x86.exe'
  url64bit               = 'https://binaries.mpc-hc.org/MPC%20HomeCinema%20-%20x64/MPC-HC_v1.7.11_x64/MPC-HC.1.7.11.x64.exe'
  checksum               = '9724a7921c48e56a365673d6a0b56660d180e145a1941d4c5110522b207dfa7d'
  checksum64             = '7f52077596b7967e9f0da30887f31963061db67da006d1d39d3b8f40f5f77c7c'
  checksumType           = 'sha256'
  checksumType64         = 'sha256'
  silentArgs             = '/VERYSILENT'
  validExitCodes         = @(0)
  softwareName           = 'mpc-hc*'
}
Install-ChocolateyPackage @packageArgs
