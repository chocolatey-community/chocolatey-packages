$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName    = 'blender'
  softwareName   = 'Blender'
  fileType       = 'MSI'
  url64bit       = 'https://download.blender.org/release/Blender3.2/blender-3.2.0-windows-x64.msi'
  checksum64     = 'd69c2fe4d6229c3840f642e6267db6292917ca567e7b05cb62efc9b7011737d6'
  checksumType64 = 'sha256'
  silentArgs     = '/quiet /norestart'
  validExitCodes = @(0, 2010, 1641)
}

Install-ChocolateyPackage @packageArgs
