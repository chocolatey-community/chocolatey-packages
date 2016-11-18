$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName            = 'smartftp'
  fileType               = 'msi'
  url                    = 'https://www.smartftp.com/get/SmartFTP86.msi'
  url64bit               = 'https://www.smartftp.com/get/SmartFTP64.msi'
  checksum               = 'ac34093d56a2d216c2eef0e4d2a843ead2a1b055577df836c9c1aa665c8a9d30'
  checksum64             = 'bcab9b5602cf681324cd82943a151ecda442a9a330fa35ac842cbdf912a4c0df'
  checksumType           = 'sha256'
  checksumType64         = 'sha256'
  silentArgs             = '/quiet'
  validExitCodes         = @(0)
  softwareName           = 'SmartFTP Client'
}
Install-ChocolateyPackage @packageArgs
