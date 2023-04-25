$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName    = 'blender'
  softwareName   = 'Blender'
  fileType       = 'MSI'
  url64bit       = 'https://download.blender.org/release/Blender3.5/blender-3.5.1-windows-x64.msi'
  checksum64     = 'c395798af29cc4a63f47af46b6a2e5aa985742dae1417fcba482270ef65e584b'
  checksumType64 = 'sha256'
  silentArgs     = '/quiet /norestart'
  validExitCodes = @(0, 2010, 1641)
}

Install-ChocolateyPackage @packageArgs
