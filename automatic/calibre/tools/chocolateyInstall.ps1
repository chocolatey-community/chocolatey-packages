$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName    = 'calibre'
  fileType       = 'MSI'
  url            = 'https://download.calibre-ebook.com/2.67.0/calibre-2.67.0.msi'
  url64Bit       = 'https://download.calibre-ebook.com/2.67.0/calibre-64bit-2.67.0.msi'
  checksum       = '623FAF9503A8A128361F9EA8E3AF0A35635D8800A3758039F2D3A2EB9D4FA9E5'
  checksum64     = '6CA8A017E29DCB4F0DC3697B7BCD75D9DE5DF698E16AB2C852E28C244CA34519'
  checksumType   = 'sha256'
  checksumType64 = 'sha256'
  silentArgs     = '/quiet'
  validExitCodes = @(0, 3010, 1641)
}

Install-ChocolateyPackage @packageArgs
