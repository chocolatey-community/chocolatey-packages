$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName    = 'blender'
  fileType       = 'msi'
  softwareName   = 'Blender'

  checksum       = '42681299b9eb169200314dee2c0969d1acc10b8d05981b0c64f4690609cd0b3f'
  checksum64     = 'd9ef1e058d4170c7d58e461480f705a197f695a753754dc30e2e88b6b249dc6a'
  checksumType   = 'sha256'
  checksumType64 = 'sha256'
  url            = 'http://ftp.nluug.nl/pub/graphics/blender/release/Blender2.78/blender-2.78a-windows32.msi'
  url64          = 'http://ftp.nluug.nl/pub/graphics/blender/release/Blender2.78/blender-2.78a-windows64.msi'

  silentArgs     = '/quiet /norestart'
  validExitCodes = @(0)
}

Install-ChocolateyPackage @packageArgs
