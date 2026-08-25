$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName    = 'blender'
  softwareName   = 'Blender'
  fileType       = 'MSI'
  url64bit       = 'https://download.blender.org/release/Blender5.2/blender-5.2.1-windows-x64.msi'
  checksum64     = 'bebb90fc5bf7e3ec7ab4eb34f4c5a5b54e28e582a722152a47fd4ee66ec3c6fa'
  checksumType64 = 'sha256'
  silentArgs     = '/quiet /norestart'
  validExitCodes = @(0, 2010, 1641)
}

Install-ChocolateyPackage @packageArgs
