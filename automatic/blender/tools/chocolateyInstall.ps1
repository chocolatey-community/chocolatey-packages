$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName    = 'blender'
  fileType       = 'msi'
  softwareName   = 'Blender'

  checksum       = 'f31f2af341d447ead18ca4b42b438db01d1f54a576ec8d86d619d5e604322436'
  checksum64     = 'c942270486b92479bcdd78a9ae2da6d96e9b49545155695b41619d9896b63018'
  checksumType   = 'sha256'
  checksumType64 = 'sha256'
  url            = 'http://ftp.nluug.nl/pub/graphics/blender/release/Blender2.78/blender-2.78b-windows32.msi'
  url64          = 'http://ftp.nluug.nl/pub/graphics/blender/release/Blender2.78/blender-2.78b-windows64.msi'

  silentArgs     = '/quiet /norestart'
  validExitCodes = @(0)
}

Install-ChocolateyPackage @packageArgs
