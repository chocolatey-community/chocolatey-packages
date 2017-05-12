$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName    = 'calibre'
  fileType       = 'MSI'
  url            = 'https://download.calibre-ebook.com/2.85.0/calibre-2.85.0.msi'
  url64Bit       = 'https://download.calibre-ebook.com/2.85.0/calibre-64bit-2.85.0.msi'
  checksum       = '3847d82492e683a203ddbb016408be2758b7080e92640e3642e1a27fe720b82a'
  checksum64     = '8309d52c0b9d5aead3d80bc4f4c56f90622028996f92e786185bc3077f305791'
  checksumType   = 'sha256'
  checksumType64 = 'sha256'
  silentArgs     = '/quiet'
  validExitCodes = @(0, 3010, 1641)
}

Install-ChocolateyPackage @packageArgs
