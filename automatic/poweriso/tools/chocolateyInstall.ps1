$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName            = 'poweriso'
  fileType               = 'exe'
  url                    = 'https://www.poweriso.com/PowerISO8.exe'
  url64bit               = 'https://www.poweriso.com/PowerISO8-x64.exe'
  checksum               = '0d95471a58872e46db96c752e078d4b981aee5f62a561c81f3256e3048717cb1'
  checksum64             = 'b3c1cb90e4eb95e307ef92e0dd883be8ddf332333833f89d6543d67a090f8303'
  checksumType           = 'sha256'
  checksumType64         = 'sha256'
  silentArgs             = '/S'
  validExitCodes         = @(0)
  softwareName           = 'poweriso*'
}
Install-ChocolateyPackage @packageArgs
