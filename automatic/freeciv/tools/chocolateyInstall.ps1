$ErrorActionPreference = 'Stop';

$packageArgs = @{
  packageName    = 'freeciv'
  fileType       = 'exe'
  softwareName   = 'Freeciv*'

  checksum       = '0fd1397a616af39a2e9b095d8c7cca6f15d498bff1dcabf099cdbdf5e08df890'
  checksumType   = 'sha256'
  url            = 'http://files.freeciv.org/packages/windows/Freeciv-2.6.2-win32-gtk3-setup.exe'

  silentArgs     = '/S'
  validExitCodes = @(0)
}

Install-ChocolateyPackage @packageArgs
