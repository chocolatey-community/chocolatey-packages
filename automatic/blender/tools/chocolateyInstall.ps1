$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName    = 'blender'
  softwareName   = 'Blender'
  fileType       = 'MSI'
  url64bit       = 'https://download.blender.org/release/Blender3.2/blender-3.2.2-windows-x64.msi'
  checksum64     = 'c91915e08d9837ccde61a329ebb6ee9cea6cd2046d7ed3a68521d87694dd9caf'
  checksumType64 = 'sha256'
  silentArgs     = '/quiet /norestart'
  validExitCodes = @(0, 2010, 1641)
}

Install-ChocolateyPackage @packageArgs
