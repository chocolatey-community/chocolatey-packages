$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName    = 'blender'
  softwareName   = 'Blender'
  fileType       = 'MSI'
  url64bit       = 'https://download.blender.org/release/Blender3.5/blender-3.5.0-windows-x64.msi'
  checksum64     = 'e2c77c59dcdaf021b087959b6a95f56eb789be79fc827ffe68d909d3be4d3019'
  checksumType64 = 'sha256'
  silentArgs     = '/quiet /norestart'
  validExitCodes = @(0, 2010, 1641)
}

Install-ChocolateyPackage @packageArgs
