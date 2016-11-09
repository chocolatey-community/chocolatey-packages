$ErrorActionPreference = 'Stop';

$packageArgs = @{
  packageName    = 'freeciv'
  fileType       = 'exe'
  softwareName   = 'Freeciv*'

  checksum       = '987a3c9e2bfaff0f1b0196ccb09589454d2ee721f91573150b25b5dd5cfd667f'
  checksumType   = 'sha256'
  url            = 'http://download.gna.org/freeciv/packages/windows/Freeciv-2.5.5-win32-gtk2-setup.exe'

  silentArgs     = '/S'
  validExitCodes = @(0)
}

Install-ChocolateyPackage @packageArgs
