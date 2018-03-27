$ErrorActionPreference = 'Stop';

$packageArgs = @{
  packageName    = 'freeciv'
  fileType       = 'exe'
  softwareName   = 'Freeciv*'

  checksum       = 'c955b8a500583c16be9a1b2541cad2555825255e37bfc3cc466cd656da135290'
  checksumType   = 'sha256'
  url            = 'http://files.freeciv.org/packages/windows/Freeciv-2.5.11-win32-gtk2-setup.exe'

  silentArgs     = '/S'
  validExitCodes = @(0)
}

Install-ChocolateyPackage @packageArgs
