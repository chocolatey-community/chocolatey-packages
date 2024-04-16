$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName    = 'blender'
  softwareName   = 'Blender'
  fileType       = 'MSI'
  url64bit       = 'https://download.blender.org/release/Blender4.1/blender-4.1.1-windows-x64.msi'
  checksum64     = 'd53c619e9af77d0e4f360559a481f70b93e37fb12dafc482deeeb6cbb7aa5ec7'
  checksumType64 = 'sha256'
  silentArgs     = '/quiet /norestart'
  validExitCodes = @(0, 2010, 1641)
}

Install-ChocolateyPackage @packageArgs
