$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName    = 'calibre'
  fileType       = 'MSI'
  url            = 'https://download.calibre-ebook.com/2.79.0/calibre-2.79.0.msi'
  url64Bit       = 'https://download.calibre-ebook.com/2.79.0/calibre-64bit-2.79.0.msi'
  checksum       = '369af7c18cf3b4e910a8e5b3462a147781b89d53e40984b96816251321aa4b5e'
  checksum64     = 'dc6edaa7c6b296df8176beb30c3a3186bcb580fe980880f48f08a610abceb59c'
  checksumType   = 'sha256'
  checksumType64 = 'sha256'
  silentArgs     = '/quiet'
  validExitCodes = @(0, 3010, 1641)
}

Install-ChocolateyPackage @packageArgs
