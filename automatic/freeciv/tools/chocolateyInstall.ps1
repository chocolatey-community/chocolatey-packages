$ErrorActionPreference = 'Stop';

$packageArgs = @{
  packageName    = 'freeciv'
  fileType       = 'exe'
  softwareName   = 'Freeciv*'

  checksum       = '4f4f09302c6457cc8a3d67ed371969ae344a133ffdb9c1e5471c9720dc5220cd'
  checksumType   = 'sha256'
  url            = 'https://files.freeciv.org/packages/windows/Freeciv-3.0.4-msys2-win64-gtk3.22-setup.exe'

  silentArgs     = '/S'
  validExitCodes = @(0)
}

Install-ChocolateyPackage @packageArgs
