$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName    = 'calibre'
  fileType       = 'MSI'
  url            = 'https://download.calibre-ebook.com/2.71.0/calibre-2.71.0.msi'
  url64Bit       = 'https://download.calibre-ebook.com/2.71.0/calibre-64bit-2.71.0.msi'
  checksum       = 'bace2369758f5ee5a0330f5102a8f8bcaf33adf378330cd2734ac189eabeef39'
  checksum64     = 'b4d2bc02a9ad4dfc2f92437b04243dd29cb6cf5f897aa82e06bfcc0be419ca81'
  checksumType   = 'sha256'
  checksumType64 = 'sha256'
  silentArgs     = '/quiet'
  validExitCodes = @(0, 3010, 1641)
}

Install-ChocolateyPackage @packageArgs
