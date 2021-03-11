$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName            = 'poweriso'
  fileType               = 'exe'
  url                    = 'https://www.poweriso.com/PowerISO6.exe'
  url64bit               = 'https://www.poweriso.com/PowerISO6-x64.exe'
  checksum               = 'a13074c2989b5633a421bea4505105506d33e584c6b3688cfab786f53674f0d8'
  checksum64             = '056d5bb3de0ea8674e39afc5215ec1c3acdc40f52ef479fe50cb09aadc251db7'
  checksumType           = 'sha256'
  checksumType64         = 'sha256'
  silentArgs             = '/S'
  validExitCodes         = @(0)
  softwareName           = 'poweriso*'
}
Install-ChocolateyPackage @packageArgs
