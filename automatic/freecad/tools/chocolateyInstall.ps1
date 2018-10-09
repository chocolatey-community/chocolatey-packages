$ErrorActionPreference = 'Stop';

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  url            = 'https://github.com/FreeCAD/FreeCAD/releases/download/0.17/FreeCAD-0.17.13528.5c3f7bf-WIN-x86-installer.exe'
  url64          = 'https://github.com/FreeCAD/FreeCAD/releases/download/0.17/FreeCAD-0.17.13541.9948ee4-WIN-x64-installer.exe'
  softwareName   = 'FreeCAD*'
  checksum       = '688aac826ae59c7995ac4a9dd5b8c2ced00127058794bd56d985095a889f6a30'
  checksumType   = 'sha256'
  checksum64     = '88bd9dd9f34d0d804b7380079cb2f32fe19e3b78fa0f9bcbf3d848d2fa17eee9'
  checksumType64 = 'sha256'
  silentArgs     = '/S'
  validExitCodes = @(0)
}

Install-ChocolateyPackage @packageArgs
