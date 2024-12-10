$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName    = 'blender'
  softwareName   = 'Blender'
  fileType       = 'MSI'
  url64bit       = 'https://download.blender.org/release/Blender4.3/blender-4.3.1-windows-x64.msi'
  checksum64     = '2a4ec70d945b5169ada08e9ae446023f0dcc5cab126883fa407456e9486ba0ed'
  checksumType64 = 'sha256'
  silentArgs     = '/quiet /norestart'
  validExitCodes = @(0, 2010, 1641)
}

Install-ChocolateyPackage @packageArgs
