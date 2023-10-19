$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName    = 'blender'
  softwareName   = 'Blender'
  fileType       = 'MSI'
  url64bit       = 'https://download.blender.org/release/Blender3.6/blender-3.6.5-windows-x64.msi'
  checksum64     = '8055ce256c68faa3ba7951790e0f7c1c760b7ce9f5f74cc1923264ded0921aed'
  checksumType64 = 'sha256'
  silentArgs     = '/quiet /norestart'
  validExitCodes = @(0, 2010, 1641)
}

Install-ChocolateyPackage @packageArgs
