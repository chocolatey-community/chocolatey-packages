$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName    = 'calibre'
  fileType       = 'MSI'
  url            = 'https://download.calibre-ebook.com/2.82.0/calibre-2.82.0.msi'
  url64Bit       = 'https://download.calibre-ebook.com/2.82.0/calibre-64bit-2.82.0.msi'
  checksum       = 'ea3e6eefcf2486b36c6bd129d13bc9a854da397aa4db3372174876da6d317d8b'
  checksum64     = '22dd17311789c17c0768055cdc3e627fded156c9d63d4efaac1e8d44a178e261'
  checksumType   = 'sha256'
  checksumType64 = 'sha256'
  silentArgs     = '/quiet'
  validExitCodes = @(0, 3010, 1641)
}

Install-ChocolateyPackage @packageArgs
