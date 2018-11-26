$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName            = 'poweriso'
  fileType               = 'exe'
  url                    = 'http://www.poweriso.com/PowerISO6.exe'
  url64bit               = 'http://www.poweriso.com/PowerISO6-x64.exe'
  checksum               = '7eb28337bf4727d37beedceabbd69d3f421ff04c26b8a3bc2fb957ef899064fd'
  checksum64             = '942511fe7e0285295aa892838d5964ac4cefa476671aa401ae8819fb2dee3f98'
  checksumType           = 'sha256'
  checksumType64         = 'sha256'
  silentArgs             = '/S'
  validExitCodes         = @(0)
  softwareName           = 'poweriso*'
}
Install-ChocolateyPackage @packageArgs
