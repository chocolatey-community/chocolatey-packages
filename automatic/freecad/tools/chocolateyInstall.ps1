$ErrorActionPreference = 'Stop';

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  url            = 'https://github.com/FreeCAD/FreeCAD/releases/download/0.16/FreeCAD.0.16.6706.f86a4e4-WIN-x86-installer.exe'
  url64          = 'https://github.com/FreeCAD/FreeCAD/releases/download/0.16.6712/FreeCAD-0.16.6712_x64_setup.exe'
  softwareName   = 'FreeCAD*'
  checksum       = '15a84512855adb0ce86e78c5424a9cb589201369aa070acc7b9467621bc434ab'
  checksumType   = 'sha256'
  checksum64     = 'a37d42ec379b8f23c54be5adb48141b7b13931827b84949e9d15698296ab856c'
  checksumType64 = 'sha256'
  silentArgs     = '/S'
  validExitCodes = @(0)
}

Install-ChocolateyPackage @packageArgs
