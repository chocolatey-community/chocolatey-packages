$ErrorActionPreference = 'Stop';

$packageArgs = @{
  packageName    = 'freeciv'
  fileType       = 'exe'
  softwareName   = 'Freeciv*'

  checksum       = 'b316d0274a010a31a32b0f3b54fa16283d6a8dc137df63fdc13345fb4d57ea19'
  checksumType   = 'sha256'
  url            = 'http://download.gna.org/freeciv/packages/windows/Freeciv-2.5.6-win32-gtk2-setup.exe'

  silentArgs     = '/S'
  validExitCodes = @(0)
}

Install-ChocolateyPackage @packageArgs
