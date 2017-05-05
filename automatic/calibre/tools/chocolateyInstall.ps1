$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName    = 'calibre'
  fileType       = 'MSI'
  url            = 'https://download.calibre-ebook.com/2.84.0/calibre-2.84.0.msi'
  url64Bit       = 'https://download.calibre-ebook.com/2.84.0/calibre-64bit-2.84.0.msi'
  checksum       = '9712fe39ec2dafb3954352a5b5810402c2955cec943d752223016005a63f20d7'
  checksum64     = 'd0b5af644bee98529d66f81ba21134e48583dfcd7cb37bc1aa38521295058203'
  checksumType   = 'sha256'
  checksumType64 = 'sha256'
  silentArgs     = '/quiet'
  validExitCodes = @(0, 3010, 1641)
}

Install-ChocolateyPackage @packageArgs
