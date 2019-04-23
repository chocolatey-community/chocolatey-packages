$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName            = 'poweriso'
  fileType               = 'exe'
  url                    = 'http://www.poweriso.com/PowerISO6.exe'
  url64bit               = 'http://www.poweriso.com/PowerISO6-x64.exe'
  checksum               = 'eaeae1ac341dd927e5992f1de3206467e1f721ab9a0a022e1a98ff2f38c28c45'
  checksum64             = 'fe52b77c1a6ac22da1498b6412cf7dc90342d6207fe6fad313398d92ef20e0bf'
  checksumType           = 'sha256'
  checksumType64         = 'sha256'
  silentArgs             = '/S'
  validExitCodes         = @(0)
  softwareName           = 'poweriso*'
}
Install-ChocolateyPackage @packageArgs
