$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName            = 'smartftp'
  fileType               = 'msi'
  url                    = 'https://www.smartftp.com/get/SmartFTP86.msi'
  url64bit               = 'https://www.smartftp.com/get/SmartFTP64.msi'
  checksum               = 'ded7c5937ad2afdec1edfe1526576edde586195153e72657c967d1cef1233923'
  checksum64             = '2a540ebbc4626bd151382d5b66fc64f1181c63d3e6855f734869f53b286eb7c9'
  checksumType           = 'sha256'
  checksumType64         = 'sha256'
  silentArgs             = '/quiet'
  validExitCodes         = @(0)
  softwareName           = 'SmartFTP Client'
}
Install-ChocolateyPackage @packageArgs
