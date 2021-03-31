$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName            = 'poweriso'
  fileType               = 'exe'
  url                    = 'https://www.poweriso.com/PowerISO7.exe'
  url64bit               = 'https://www.poweriso.com/PowerISO7-x64.exe'
  checksum               = '452fbac2cf20234aea0053c59b37cb951e4c6bcd69597b2dff04e254e7497a00'
  checksum64             = '3a9f8a8b4c9bb743de10b22b4e2ae63d29b7c6f1914cf1ab717cc45342375191'
  checksumType           = 'sha256'
  checksumType64         = 'sha256'
  silentArgs             = '/S'
  validExitCodes         = @(0)
  softwareName           = 'poweriso*'
}
Install-ChocolateyPackage @packageArgs
