$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName    = 'calibre'
  fileType       = 'MSI'
  url            = 'https://download.calibre-ebook.com/2.70.0/calibre-2.70.0.msi'
  url64Bit       = 'https://download.calibre-ebook.com/2.70.0/calibre-64bit-2.70.0.msi'
  checksum       = '6d60efbabf72d74d3c422a7afd2d0c46c4fe24349ef441f01ed001e9c3d5fd06'
  checksum64     = '8d3007517514dd7d81fa8ac7a1afb5bb21a8e16a39d754a8d7b0991ea28392d1'
  checksumType   = 'sha256'
  checksumType64 = 'sha256'
  silentArgs     = '/quiet'
  validExitCodes = @(0, 3010, 1641)
}

Install-ChocolateyPackage @packageArgs
