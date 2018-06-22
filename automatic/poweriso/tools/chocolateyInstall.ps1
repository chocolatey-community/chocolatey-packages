$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName            = 'poweriso'
  fileType               = 'exe'
  url                    = 'http://www.poweriso.com/PowerISO6.exe'
  url64bit               = 'http://www.poweriso.com/PowerISO6-x64.exe'
  checksum               = '55127d5325c0fefc646c74d39e625d1f848860b8fd98666626bc8a4f5fb0345c'
  checksum64             = 'dbef8bdcb3eda13635e66dd43388d10883afc68663e11fc1fbb96609014ff92f'
  checksumType           = 'sha256'
  checksumType64         = 'sha256'
  silentArgs             = '/S'
  validExitCodes         = @(0)
  softwareName           = 'poweriso*'
}
Install-ChocolateyPackage @packageArgs
