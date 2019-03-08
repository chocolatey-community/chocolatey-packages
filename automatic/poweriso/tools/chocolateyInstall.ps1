$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName            = 'poweriso'
  fileType               = 'exe'
  url                    = 'http://www.poweriso.com/PowerISO6.exe'
  url64bit               = 'http://www.poweriso.com/PowerISO6-x64.exe'
  checksum               = '870eedc81f81a6c884815229dd4a07f0ec4882d7e46bd18d44c9806808887408'
  checksum64             = '9178e9cbc6e91999c47d08e36a9863dd29950335462da9670debb49bb6bb63b9'
  checksumType           = 'sha256'
  checksumType64         = 'sha256'
  silentArgs             = '/S'
  validExitCodes         = @(0)
  softwareName           = 'poweriso*'
}
Install-ChocolateyPackage @packageArgs
