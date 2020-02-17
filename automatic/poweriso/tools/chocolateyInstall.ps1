$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName            = 'poweriso'
  fileType               = 'exe'
  url                    = 'http://www.poweriso.com/PowerISO6.exe'
  url64bit               = 'http://www.poweriso.com/PowerISO6-x64.exe'
  checksum               = 'd4da73d04dec6fb7628419c995e6cb08ef236814aac3c720c0c248b9477f7895'
  checksum64             = '9baf7fc309ff97ceb8361ed2b3486c33a2ba40d304c7623ebe8cf1c8ceb44a6e'
  checksumType           = 'sha256'
  checksumType64         = 'sha256'
  silentArgs             = '/S'
  validExitCodes         = @(0)
  softwareName           = 'poweriso*'
}
Install-ChocolateyPackage @packageArgs
