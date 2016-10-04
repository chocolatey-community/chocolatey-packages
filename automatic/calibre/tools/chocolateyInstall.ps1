$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName    = 'calibre'
  fileType       = 'MSI'
  url            = 'https://download.calibre-ebook.com/2.68.0/calibre-2.68.0.msi'
  url64Bit       = 'https://download.calibre-ebook.com/2.68.0/calibre-64bit-2.68.0.msi'
  checksum       = '08717BBC3B37A664EDE623BC3B8C99AFD831792BFAEE5E61C935BE94159F7304'
  checksum64     = '69991DB1AC753E4A5586432D6970012E3278B9B0FE38E1670C4F323CAC25E317'
  checksumType   = 'sha256'
  checksumType64 = 'sha256'
  silentArgs     = '/quiet'
  validExitCodes = @(0, 3010, 1641)
}

Install-ChocolateyPackage @packageArgs
