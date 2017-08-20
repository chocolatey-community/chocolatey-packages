$ErrorActionPreference = 'Stop';

$packageArgs = @{
  packageName    = 'freeciv'
  fileType       = 'exe'
  softwareName   = 'Freeciv*'

  checksum       = '63555744d0d18fa209b98b89a5b005cac7dee804f397445c82c3bd88134d5e31'
  checksumType   = 'sha256'
  url            = 'http://files.freeciv.org/packages/windows/Freeciv-2.5.9-win32-gtk2-setup.exe'

  silentArgs     = '/S'
  validExitCodes = @(0)
}

Install-ChocolateyPackage @packageArgs
