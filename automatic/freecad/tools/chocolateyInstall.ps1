$ErrorActionPreference = 'Stop';

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  url            = 'https://github.com/FreeCAD/FreeCAD/releases/download/0.17/FreeCAD-0.17.13522.3bb5ff4-WIN-x86-installer.exe'
  url64          = 'https://github.com/FreeCAD/FreeCAD/releases/download/0.17/FreeCAD-0.17.13522.3bb5ff4-WIN-x64-installer.exe'
  softwareName   = 'FreeCAD*'
  checksum       = '4f5955c8dfe73c96338f28d62e10608459e8c18bfe1567619d1561b635c21fbe'
  checksumType   = 'sha256'
  checksum64     = '4b8038afe9d67bf27bb2976a39499ffbc4ee92bd98e8f6aa9cb507d6d06b313d'
  checksumType64 = 'sha256'
  silentArgs     = '/S'
  validExitCodes = @(0)
}

Install-ChocolateyPackage @packageArgs
