$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName    = 'blender'
  softwareName   = 'Blender'
  fileType       = 'MSI'
  url64bit       = 'https://download.blender.org/release/Blender4.0/blender-4.0.2-windows-x64.msi'
  checksum64     = '38485adda7cc076ebbfa5017ffab214a6dd6290bf183f87d0b1c14aab68ee68b'
  checksumType64 = 'sha256'
  silentArgs     = '/quiet /norestart'
  validExitCodes = @(0, 2010, 1641)
}

Install-ChocolateyPackage @packageArgs
