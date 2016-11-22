$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName            = 'smartftp'
  fileType               = 'msi'
  url                    = 'https://www.smartftp.com/get/SmartFTP86.msi'
  url64bit               = 'https://www.smartftp.com/get/SmartFTP64.msi'
  checksum               = 'd3bc0494d88c488e603c1c6a0bfa14dc554d7bb3b780a0b9519097d9017b046a'
  checksum64             = '9d3d7eb66baee0ea788be4a60973c56ae6e0ffcc702139dbbe06a2e9937853ea'
  checksumType           = 'sha256'
  checksumType64         = 'sha256'
  silentArgs             = '/quiet'
  validExitCodes         = @(0)
  softwareName           = 'SmartFTP Client'
}
Install-ChocolateyPackage @packageArgs
