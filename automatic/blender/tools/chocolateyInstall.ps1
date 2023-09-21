$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName    = 'blender'
  softwareName   = 'Blender'
  fileType       = 'MSI'
  url64bit       = 'https://download.blender.org/release/Blender3.6/blender-3.6.3-windows-x64.msi'
  checksum64     = '8a2d77198a741c456ff930cb09b6fac5ea42924a3a64bbe6d6fbd9f3a4cbda12'
  checksumType64 = 'sha256'
  silentArgs     = '/quiet /norestart'
  validExitCodes = @(0, 2010, 1641)
}

Install-ChocolateyPackage @packageArgs
