$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName    = 'calibre'
  fileType       = 'MSI'
  url            = 'https://download.calibre-ebook.com/2.75.0/calibre-2.75.0.msi'
  url64Bit       = 'https://download.calibre-ebook.com/2.75.0/calibre-64bit-2.75.0.msi'
  checksum       = '1ee50e81625facae55d6dec85b2c65665ce0faf99fd10621e54f6a83bc1310bb'
  checksum64     = '6e59c009477cfdd9758e361556456984327a87eaba3a2089b219b9c179e87823'
  checksumType   = 'sha256'
  checksumType64 = 'sha256'
  silentArgs     = '/quiet'
  validExitCodes = @(0, 3010, 1641)
}

Install-ChocolateyPackage @packageArgs
