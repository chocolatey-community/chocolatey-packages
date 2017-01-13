$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName    = 'calibre'
  fileType       = 'MSI'
  url            = 'https://download.calibre-ebook.com/2.77.0/calibre-2.77.0.msi'
  url64Bit       = 'https://download.calibre-ebook.com/2.77.0/calibre-64bit-2.77.0.msi'
  checksum       = '373337fb8d8c797bac23393b3f7dd56661d4b358a2eb80ab88f0992a566e9dd8'
  checksum64     = '59a75d0ea9cef5b998d66748f67a4c621cccf62ebb44cd1a23d9af1a0c522042'
  checksumType   = 'sha256'
  checksumType64 = 'sha256'
  silentArgs     = '/quiet'
  validExitCodes = @(0, 3010, 1641)
}

Install-ChocolateyPackage @packageArgs
