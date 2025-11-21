$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName    = 'blender'
  softwareName   = 'Blender'
  fileType       = 'MSI'
  url64bit       = 'https://download.blender.org/release/Blender5.0/blender-5.0.0-windows-x64.msi'
  checksum64     = '69f662f5c4adf3bfa3fa8ba60504ad6fed723ad1d33fe22d718cdeb47ef27895'
  checksumType64 = 'sha256'
  silentArgs     = '/quiet /norestart'
  validExitCodes = @(0, 2010, 1641)
}

Install-ChocolateyPackage @packageArgs
