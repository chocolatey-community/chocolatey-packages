$ErrorActionPreference = 'Stop';

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  url            = 'https://github.com/FreeCAD/FreeCAD/releases/download/0.18.3/FreeCAD-0.18.16131.3129ae4-WIN-x32-installer.exe'
  url64          = 'https://github.com/FreeCAD/FreeCAD/releases/download/0.18.3/FreeCAD-0.18.16131.3129ae4-WIN-x64-installer.exe'
  softwareName   = 'FreeCAD*'
  checksum       = 'ef5d4108329c71b4b5b60fbe2fbc49acef86694942e83765a4863010eabe0d79'
  checksumType   = 'sha256'
  checksum64     = 'c521b8ca5dd9ed287bc3afbe57aa39f4dea4ca89e13fb58c3258d3792f86d48f'
  checksumType64 = 'sha256'
  silentArgs     = '/S'
  validExitCodes = @(0)
}

Install-ChocolateyPackage @packageArgs
