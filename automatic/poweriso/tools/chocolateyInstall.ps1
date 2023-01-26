$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName            = 'poweriso'
  fileType               = 'exe'
  url                    = 'https://www.poweriso.com/PowerISO8.exe'
  url64bit               = 'https://www.poweriso.com/PowerISO8-x64.exe'
  checksum               = '53f500dcad80ad5a573660c1e11649f367a32a2f778c9fbdcd8348c4004dc53b'
  checksum64             = '98e729bb1cb98d16a7c584fe38cc634fdbbd855170e90f94bfcf5352bb3139ee'
  checksumType           = 'sha256'
  checksumType64         = 'sha256'
  silentArgs             = '/S'
  validExitCodes         = @(0)
  softwareName           = 'poweriso*'
}
Install-ChocolateyPackage @packageArgs
