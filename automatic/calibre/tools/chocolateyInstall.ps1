$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName    = 'calibre'
  fileType       = 'MSI'
  url            = 'https://download.calibre-ebook.com/2.78.0/calibre-2.78.0.msi'
  url64Bit       = 'https://download.calibre-ebook.com/2.78.0/calibre-64bit-2.78.0.msi'
  checksum       = '03976eac147e281f76e5bb7b1421814bde9051c6bf6332c4fd03d89bc915211b'
  checksum64     = 'fde48a9c661fe4b31435b5eac9e2434304de81dd47980b70e5d106419ef8ed07'
  checksumType   = 'sha256'
  checksumType64 = 'sha256'
  silentArgs     = '/quiet'
  validExitCodes = @(0, 3010, 1641)
}

Install-ChocolateyPackage @packageArgs
