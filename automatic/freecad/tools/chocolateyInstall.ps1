$ErrorActionPreference = 'Stop';

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  url            = 'https://github.com/FreeCAD/FreeCAD/releases/download/0.17/FreeCAD-0.17.13522.3bb5ff4-WIN-x86-installer.exe'
  url64          = 'https://github.com/FreeCAD/FreeCAD/releases/download/0.17/FreeCAD-0.17.13519.1a8b868-WIN-x64-installer.exe'
  softwareName   = 'FreeCAD*'
  checksum       = '59dc8b1df5ea58fa670437631ad9527d52009331745c0cb063e45b2f36f5e52e'
  checksumType   = 'sha256'
  checksum64     = 'fee14c06da132986d08cf37b225685c12c85111e84188af0cad9251f7ea26cf4'
  checksumType64 = 'sha256'
  silentArgs     = '/S'
  validExitCodes = @(0)
}

Install-ChocolateyPackage @packageArgs
