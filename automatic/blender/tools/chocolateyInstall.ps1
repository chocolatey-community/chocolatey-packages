$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName    = 'blender'
  softwareName   = 'Blender'
  fileType       = 'MSI'
  url64bit       = 'https://download.blender.org/release/Blender4.4/blender-4.4.1-windows-x64.msi'
  checksum64     = '37a2cfc8c05a9929be35fe337683736df05a9700d053f25373223c281a77659e'
  checksumType64 = 'sha256'
  silentArgs     = '/quiet /norestart'
  validExitCodes = @(0, 2010, 1641)
}

Install-ChocolateyPackage @packageArgs
