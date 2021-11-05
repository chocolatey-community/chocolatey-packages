$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName            = 'poweriso'
  fileType               = 'exe'
  url                    = 'https://www.poweriso.com/PowerISO8.exe'
  url64bit               = 'https://www.poweriso.com/PowerISO8-x64.exe'
  checksum               = 'ec0849234e579822c5742249a01da301f9cf9a2a9756769477f716ed45faf109'
  checksum64             = 'd239d3c35ab70b7854b34921ceac3e71d84bb90187d34076d9d1420fdb7cb058'
  checksumType           = 'sha256'
  checksumType64         = 'sha256'
  silentArgs             = '/S'
  validExitCodes         = @(0)
  softwareName           = 'poweriso*'
}
Install-ChocolateyPackage @packageArgs
