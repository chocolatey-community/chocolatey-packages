$ErrorActionPreference = 'Stop';

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  url            = 'https://github.com/FreeCAD/FreeCAD/releases/download/0.18.1/FreeCAD-0.18.16110.f7dccfa-WIN-x32-installer.exe'
  url64          = 'https://github.com/FreeCAD/FreeCAD/releases/download/0.18.1/FreeCAD-0.18.16110.f7dccfa-WIN-x64-installer.exe'
  softwareName   = 'FreeCAD*'
  checksum       = 'd5d30471d0c79b9588f1504e606e146f61512b17371577f6bb12b32bc6cac2a0'
  checksumType   = 'sha256'
  checksum64     = '1a4e842ce39850a2efeec3ed16ca59e4c8a720c16999ce0724e22a20c5db5540'
  checksumType64 = 'sha256'
  silentArgs     = '/S'
  validExitCodes = @(0)
}

Install-ChocolateyPackage @packageArgs
