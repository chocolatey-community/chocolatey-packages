$ErrorActionPreference = 'Stop';

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  url            = 'https://github.com/FreeCAD/FreeCAD/releases/download/0.18.4/FreeCAD-0.18.4.980bf90-WIN-x32-installer.exe'
  url64          = 'https://github.com/FreeCAD/FreeCAD/releases/download/0.18.4/FreeCAD-0.18.4.980bf90-WIN-x64-installer.exe'
  softwareName   = 'FreeCAD*'
  checksum       = 'a3c00e00e5321d9786c56d58c501f8a8e43ba9d25f7147cd8b9c869d744be514'
  checksumType   = 'sha256'
  checksum64     = 'd70930110929117c3a198d3c815a9169e383ab88f650431a1a1ece7705d2ef1b'
  checksumType64 = 'sha256'
  silentArgs     = '/S'
  validExitCodes = @(0)
}

Install-ChocolateyPackage @packageArgs
