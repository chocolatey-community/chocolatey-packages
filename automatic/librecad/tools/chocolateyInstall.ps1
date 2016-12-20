$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName    = 'librecad'
  fileType       = 'exe'
  softwareName   = 'LibreCAD'

  checksum       = '4c0855316934fbb9af712df2bdbc7c11e46b4569af2e6f2d4d7e6574d13f05cb'
  checksumType   = 'sha256'
  url            = 'https://github.com/LibreCAD/LibreCAD/releases/download/2.1.3/LibreCAD-Installer-2.1.3.exe'

  silentArgs     = '/S'
  validExitCodes = @(0)
}

Install-ChocolateyPackage @packageArgs
