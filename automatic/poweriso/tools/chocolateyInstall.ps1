$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName            = 'poweriso'
  fileType               = 'exe'
  url                    = 'https://www.poweriso.com/PowerISO8.exe'
  url64bit               = 'https://www.poweriso.com/PowerISO8-x64.exe'
  checksum               = '5ee07c6b84358cf64c2b8de2a409493cbcdccb4ab0e44a9e141b103eab0bd8be'
  checksum64             = '2f5795b8b0db6b2d205d3722b91ab2d7f034ff40a9480a869514c0921bc0cee4'
  checksumType           = 'sha256'
  checksumType64         = 'sha256'
  silentArgs             = '/S'
  validExitCodes         = @(0)
  softwareName           = 'poweriso*'
}
Install-ChocolateyPackage @packageArgs
