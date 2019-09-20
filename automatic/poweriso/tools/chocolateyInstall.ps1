$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName            = 'poweriso'
  fileType               = 'exe'
  url                    = 'http://www.poweriso.com/PowerISO6.exe'
  url64bit               = 'http://www.poweriso.com/PowerISO6-x64.exe'
  checksum               = '6a3805021251e6636d6072b1c185cdf507e94771de4c7b1c03a973c82bdbfa14'
  checksum64             = 'c6b45d514c917ee6ece784f6578f8c6eb67e1a8846d335d9342dff25df20135b'
  checksumType           = 'sha256'
  checksumType64         = 'sha256'
  silentArgs             = '/S'
  validExitCodes         = @(0)
  softwareName           = 'poweriso*'
}
Install-ChocolateyPackage @packageArgs
