$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName            = 'poweriso'
  fileType               = 'exe'
  url                    = 'https://www.poweriso.com/PowerISO8.exe'
  url64bit               = 'https://www.poweriso.com/PowerISO8-x64.exe'
  checksum               = '306070dde8c4f81fbe1555e80c19e27a42238ca056bc35c9d347f160e749aae2'
  checksum64             = '38afa6dace6f58373927adc8596415e6a28d1738bbe8987f1a566fe723d57e21'
  checksumType           = 'sha256'
  checksumType64         = 'sha256'
  silentArgs             = '/S'
  validExitCodes         = @(0)
  softwareName           = 'poweriso*'
}
Install-ChocolateyPackage @packageArgs
