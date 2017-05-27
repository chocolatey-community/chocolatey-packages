$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName            = 'poweriso'
  fileType               = 'exe'
  url                    = 'http://www.poweriso.com/tightrope/PowerISO6.exe'
  url64bit               = 'http://www.poweriso.com/tightrope/PowerISO6-x64.exe'
  checksum               = ''
  checksum64             = ''
  checksumType           = 'sha256'
  checksumType64         = 'sha256'
  silentArgs             = '/S'
  validExitCodes         = @(0)
  softwareName           = 'poweriso*'
}
Install-ChocolateyPackage @packageArgs
