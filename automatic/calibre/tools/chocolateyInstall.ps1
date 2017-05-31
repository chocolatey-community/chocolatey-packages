$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName    = 'calibre'
  fileType       = 'MSI'
  url            = 'https://download.calibre-ebook.com/2.85.1/calibre-2.85.1.msi'
  url64Bit       = 'https://download.calibre-ebook.com/2.85.1/calibre-64bit-2.85.1.msi'
  checksum       = 'e7c1e0f489911e59bea163c520ec81c333f717ac3f5c53969a342c7cf600eb83'
  checksum64     = '1318596d26e8b2b6fb5a44bb47bc67ce8b70aba48dc2428c8e8bae562e224532'
  checksumType   = 'sha256'
  checksumType64 = 'sha256'
  silentArgs     = '/quiet'
  validExitCodes = @(0, 3010, 1641)
}

Install-ChocolateyPackage @packageArgs
