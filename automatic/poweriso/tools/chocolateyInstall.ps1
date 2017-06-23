$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName            = 'poweriso'
  fileType               = 'exe'
  url                    = 'http://www.poweriso.com/tightrope/PowerISO6.exe'
  url64bit               = 'http://www.poweriso.com/tightrope/PowerISO6-x64.exe'
  checksum               = 'a3b6d2781b59d3b2f7e55c0cd686463cddfce090e5058db021a75d3450686f48'
  checksum64             = 'c518be6f5a4324b4ea6f1e5f2f792afbc714f2b2290669604eb9b03fb5a3a64f'
  checksumType           = 'sha256'
  checksumType64         = 'sha256'
  silentArgs             = '/S'
  validExitCodes         = @(0)
  softwareName           = 'poweriso*'
}
Install-ChocolateyPackage @packageArgs
