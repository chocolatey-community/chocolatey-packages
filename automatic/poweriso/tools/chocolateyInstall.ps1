$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName            = 'poweriso'
  fileType               = 'exe'
  url                    = 'https://www.poweriso.net/PowerISO9.exe'
  url64bit               = 'https://www.poweriso.net/PowerISO9-x64.exe'
  checksum               = 'f7ce0ca449199fea357bc0faf07a4c2a0d95c923d7d808a0c084f9ba6d59ae82'
  checksum64             = '105bc76ac37570568aac5d1a4007fd24ed2c3176bb25866b2658c4a59fc882fd'
  checksumType           = 'sha256'
  checksumType64         = 'sha256'
  silentArgs             = '/S'
  validExitCodes         = @(0)
  softwareName           = 'poweriso*'
}
Install-ChocolateyPackage @packageArgs
