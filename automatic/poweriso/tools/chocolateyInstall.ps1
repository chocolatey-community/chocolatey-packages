$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName            = 'poweriso'
  fileType               = 'exe'
  url                    = 'https://www.poweriso.com/PowerISO8.exe'
  url64bit               = 'https://www.poweriso.com/PowerISO8-x64.exe'
  checksum               = '43971e39d3d9d4da869a3dc0de4fa2ad264b479da21a459525eceddc0f0afcf1'
  checksum64             = '09e4b993ede689663a6a7322946fc1f288b8706d14dc7bc0d36a06d5033b48c7'
  checksumType           = 'sha256'
  checksumType64         = 'sha256'
  silentArgs             = '/S'
  validExitCodes         = @(0)
  softwareName           = 'poweriso*'
}
Install-ChocolateyPackage @packageArgs
