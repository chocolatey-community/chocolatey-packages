$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName    = 'blender'
  softwareName   = 'Blender'
  fileType       = 'MSI'
  url64bit       = 'https://download.blender.org/release/Blender4.2/blender-4.2.3-windows-x64.msi'
  checksum64     = '536538b0e04caf83d4df071fe3a99181d9273486f5ba4cb43bbaefd1db4dd5be'
  checksumType64 = 'sha256'
  silentArgs     = '/quiet /norestart'
  validExitCodes = @(0, 2010, 1641)
}

Install-ChocolateyPackage @packageArgs
