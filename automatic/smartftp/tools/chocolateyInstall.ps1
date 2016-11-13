$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName            = 'smartftp'
  fileType               = 'msi'
  url                    = 'https://www.smartftp.com/get/SmartFTP86.msi'
  url64bit               = 'https://www.smartftp.com/get/SmartFTP64.msi'
  checksum               = '158579bb951bbeda3b1f10a80bb70d9013ce0affe90a2c8f55396f81d5e5f1ea'
  checksum64             = '9e73ae940f50b2af7924cd521933d624ad17b61b1282323462acf0a26f29a39d'
  checksumType           = 'sha256'
  checksumType64         = 'sha256'
  silentArgs             = '/quiet'
  validExitCodes         = @(0)
  softwareName           = 'SmartFTP Client'
}
Install-ChocolateyPackage @packageArgs
