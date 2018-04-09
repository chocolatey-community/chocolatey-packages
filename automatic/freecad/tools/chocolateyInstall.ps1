$ErrorActionPreference = 'Stop';

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  url            = 'https://github.com/FreeCAD/FreeCAD/releases/download/0.17/FreeCAD-0.17.13509.0258808-WIN-x86-installer.exe'
  url64          = 'https://github.com/FreeCAD/FreeCAD/releases/download/0.17/FreeCAD-0.17.13509.0258808-WIN-x64-installer.exe'
  softwareName   = 'FreeCAD*'
  checksum       = '4b071a1f6ccb104055c5dfe18111dab1150b35a8e47fe0a99988262f6289456a'
  checksumType   = 'sha256'
  checksum64     = 'dc71e49619ce4023ffd40b52e8a1e102a485de82ae61b20358343ddc03807938'
  checksumType64 = 'sha256'
  silentArgs     = '/S'
  validExitCodes = @(0)
}

Install-ChocolateyPackage @packageArgs
