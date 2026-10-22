$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName    = 'blender'
  softwareName   = 'Blender'
  fileType       = 'MSI'
  url64bit       = 'https://download.blender.org/release/Blender5.2/blender-5.2.3-windows-x64.msi'
  checksum64     = 'a103d4ece8d9acffd2a95c9d8860355b1f209977cc983b4a3d1e1cfb441c8605'
  checksumType64 = 'sha256'
  silentArgs     = '/quiet /norestart'
  validExitCodes = @(0, 2010, 1641)
}

Install-ChocolateyPackage @packageArgs
