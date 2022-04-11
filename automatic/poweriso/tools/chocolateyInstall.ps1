$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName            = 'poweriso'
  fileType               = 'exe'
  url                    = 'https://www.poweriso.com/PowerISO8.exe'
  url64bit               = 'https://www.poweriso.com/PowerISO8-x64.exe'
  checksum               = '4b12a3a8175a0066bf49b16ea05a76061a05e48e28652af48b664eadec62f377'
  checksum64             = 'ddfda881e7f0806cec42e0148c9b357d0b877e95c03db491c5a66f516f4ba4bf'
  checksumType           = 'sha256'
  checksumType64         = 'sha256'
  silentArgs             = '/S'
  validExitCodes         = @(0)
  softwareName           = 'poweriso*'
}
Install-ChocolateyPackage @packageArgs
