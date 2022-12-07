$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName    = 'blender'
  softwareName   = 'Blender'
  fileType       = 'MSI'
  url64bit       = 'https://download.blender.org/release/Blender3.4/blender-3.4.0-windows-x64.msi'
  checksum64     = 'bbd6518d7bd39e8f28a6f21c4103ff1ad337105853120c3c33ebea7569a7df0c'
  checksumType64 = 'sha256'
  silentArgs     = '/quiet /norestart'
  validExitCodes = @(0, 2010, 1641)
}

Install-ChocolateyPackage @packageArgs
