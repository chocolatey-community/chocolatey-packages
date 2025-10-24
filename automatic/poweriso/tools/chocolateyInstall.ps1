$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName            = 'poweriso'
  fileType               = 'exe'
  url                    = 'https://www.poweriso.net/PowerISO9.exe'
  url64bit               = 'https://www.poweriso.net/PowerISO9-x64.exe'
  checksum               = '7128bc6068960d274d6c567a5ffb57cbe4f33cb5c26791b1af700d1197ad4fda'
  checksum64             = '735ed7adcd9ccf0895b86bfa21aa076f3f38b893353af23f6ce4ef588861a307'
  checksumType           = 'sha256'
  checksumType64         = 'sha256'
  silentArgs             = '/S'
  validExitCodes         = @(0)
  softwareName           = 'poweriso*'
}
Install-ChocolateyPackage @packageArgs
