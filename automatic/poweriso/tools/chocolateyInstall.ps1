$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName            = 'poweriso'
  fileType               = 'exe'
  url                    = 'https://www.poweriso.net/PowerISO9.exe'
  url64bit               = 'https://www.poweriso.net/PowerISO9-x64.exe'
  checksum               = '2f2ffe6ca58acf44fe5329a1d6fdb97bf20f02962b22ff403dc82a19287c55f4'
  checksum64             = 'e86986b849aa32270ede79012357161544c0647329d5e8d1d68ae505ac765c91'
  checksumType           = 'sha256'
  checksumType64         = 'sha256'
  silentArgs             = '/S'
  validExitCodes         = @(0)
  softwareName           = 'poweriso*'
}
Install-ChocolateyPackage @packageArgs
