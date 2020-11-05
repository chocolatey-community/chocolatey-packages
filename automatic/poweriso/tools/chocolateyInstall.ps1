$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName            = 'poweriso'
  fileType               = 'exe'
  url                    = 'http://www.poweriso.com/PowerISO6.exe'
  url64bit               = 'http://www.poweriso.com/PowerISO6-x64.exe'
  checksum               = '0b6fdb1ec4abad25251a4c66771a1775aa5a04e49174f64971123cbb2fda32c3'
  checksum64             = '35daaf8499f3c702ff7040c246733b020a1270a0bc4ec243bb4b927b8281e92a'
  checksumType           = 'sha256'
  checksumType64         = 'sha256'
  silentArgs             = '/S'
  validExitCodes         = @(0)
  softwareName           = 'poweriso*'
}
Install-ChocolateyPackage @packageArgs
