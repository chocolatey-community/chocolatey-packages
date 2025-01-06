$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName            = 'poweriso'
  fileType               = 'exe'
  url                    = 'https://www.poweriso.com/PowerISO9.exe'
  url64bit               = 'https://www.poweriso.com/PowerISO9-x64.exe'
  checksum               = '1201cc021d65293fa9821bafe44b2e1aa15f543efeb7f867d7316b4fad7c9c56'
  checksum64             = '7b5c0e774cb08b50b06ce3eea79852d3302d2dd7316357027bdb044de588ecbe'
  checksumType           = 'sha256'
  checksumType64         = 'sha256'
  silentArgs             = '/S'
  validExitCodes         = @(0)
  softwareName           = 'poweriso*'
}
Install-ChocolateyPackage @packageArgs
