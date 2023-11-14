$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName    = 'blender'
  softwareName   = 'Blender'
  fileType       = 'MSI'
  url64bit       = 'https://download.blender.org/release/Blender4.0/blender-4.0.0-windows-x64.msi'
  checksum64     = 'c1b8bb8907a329da200bf0d457748f3da86c2d1a204bbcd0be3bccde7e056ef0'
  checksumType64 = 'sha256'
  silentArgs     = '/quiet /norestart'
  validExitCodes = @(0, 2010, 1641)
}

Install-ChocolateyPackage @packageArgs
