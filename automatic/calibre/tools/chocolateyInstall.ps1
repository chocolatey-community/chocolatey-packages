$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName    = 'calibre'
  fileType       = 'MSI'
  url            = 'https://download.calibre-ebook.com/2.80.0/calibre-2.80.0.msi'
  url64Bit       = 'https://download.calibre-ebook.com/2.80.0/calibre-64bit-2.80.0.msi'
  checksum       = '4a2d41551471f76df7bed4d7ca268e562e6aa3e0780f7e707c464fdf2659b58d'
  checksum64     = 'c81759a6cf23773b57eb82c2182ebf5b6b56ac7e54fa8d5dd9a255291b3b5be1'
  checksumType   = 'sha256'
  checksumType64 = 'sha256'
  silentArgs     = '/quiet'
  validExitCodes = @(0, 3010, 1641)
}

Install-ChocolateyPackage @packageArgs
