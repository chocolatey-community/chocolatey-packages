$ErrorActionPreference = 'Stop';

$packageArgs = @{
  packageName    = 'freeciv'
  fileType       = 'exe'
  softwareName   = 'Freeciv*'

  checksum       = '56bc82e88e5c19fbd9b615e39f493cf9474f0dedf8fa2d175992c261d61065eb'
  checksumType   = 'sha256'
  url            = 'http://files.freeciv.org/packages/windows/Freeciv-2.5.7-win32-gtk2-setup.exe'

  silentArgs     = '/S'
  validExitCodes = @(0)
}

Install-ChocolateyPackage @packageArgs
