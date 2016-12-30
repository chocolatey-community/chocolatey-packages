$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName    = 'calibre'
  fileType       = 'MSI'
  url            = 'https://download.calibre-ebook.com/2.76.0/calibre-2.76.0.msi'
  url64Bit       = 'https://download.calibre-ebook.com/2.76.0/calibre-64bit-2.76.0.msi'
  checksum       = '400264bc86d295563619bac520037a856c49c91875545e925862d8bf1ac89f95'
  checksum64     = '9234768b373c0da26b0d24160dd953fdae8a711c79aae50dd96c33bb9567fd21'
  checksumType   = 'sha256'
  checksumType64 = 'sha256'
  silentArgs     = '/quiet'
  validExitCodes = @(0, 3010, 1641)
}

Install-ChocolateyPackage @packageArgs
