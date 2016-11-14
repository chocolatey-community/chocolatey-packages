$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName            = 'smartftp'
  fileType               = 'msi'
  url                    = 'https://www.smartftp.com/get/SmartFTP86.msi'
  url64bit               = 'https://www.smartftp.com/get/SmartFTP64.msi'
  checksum               = 'cfa48732506d969f564ec8530c746020d4c902746f55b82974241b56267ddf67'
  checksum64             = '83f9ce0b11d05c63efd6be8ec9bb4404801abc4867dae5534117a339d111c2dc'
  checksumType           = 'sha256'
  checksumType64         = 'sha256'
  silentArgs             = '/quiet'
  validExitCodes         = @(0)
  softwareName           = 'SmartFTP Client'
}
Install-ChocolateyPackage @packageArgs
