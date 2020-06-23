$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName            = 'poweriso'
  fileType               = 'exe'
  url                    = 'http://www.poweriso.com/PowerISO6.exe'
  url64bit               = 'http://www.poweriso.com/PowerISO6-x64.exe'
  checksum               = 'b452e3a56322aae4aa5d85b17541880effde6a167361b183d85362e8e2218ab2'
  checksum64             = '3091d70c76a7c392f7524ef1bdcaf1d754f33259c2df03ccc627b2cc4545ec9c'
  checksumType           = 'sha256'
  checksumType64         = 'sha256'
  silentArgs             = '/S'
  validExitCodes         = @(0)
  softwareName           = 'poweriso*'
}
Install-ChocolateyPackage @packageArgs
