$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName    = 'blender'
  fileType       = 'msi'
  softwareName   = 'Blender'

  checksum       = '43182f504d30074f4ee528e68ff1b0ef85e9e291100db428cee32d457014aeba'
  checksum64     = '52e4b13e39fa2175fa95f71bfa043df987aa58ee6ca3ab2a64cd924596577772'
  checksumType   = 'sha256'
  checksumType64 = 'sha256'
  url            = 'http://ftp.nluug.nl/pub/graphics/blender/release/Blender2.78/blender-2.78c-windows32.msi'
  url64          = 'http://ftp.nluug.nl/pub/graphics/blender/release/Blender2.78/blender-2.78c-windows64.msi'

  silentArgs     = '/quiet /norestart'
  validExitCodes = @(0)
}

Install-ChocolateyPackage @packageArgs
