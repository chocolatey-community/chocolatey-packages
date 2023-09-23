$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName            = 'poweriso'
  fileType               = 'exe'
  url                    = 'https://www.poweriso.com/PowerISO8.exe'
  url64bit               = 'https://www.poweriso.com/PowerISO8-x64.exe'
  checksum               = '26cf123fcc6b18852866dfc6a5e2aeb8e5b18bad0103e6e26f32e7652f566e8d'
  checksum64             = '2077dc0a4884393d16e3b0f5d75a10f0e6c6ee4fe6037ee8f6e1084e6af590bd'
  checksumType           = 'sha256'
  checksumType64         = 'sha256'
  silentArgs             = '/S'
  validExitCodes         = @(0)
  softwareName           = 'poweriso*'
}
Install-ChocolateyPackage @packageArgs
