$ErrorActionPreference = 'Stop';

$packageArgs = @{
  packageName    = 'freeciv'
  fileType       = 'exe'
  softwareName   = 'Freeciv*'

  checksum       = '025e04192f8cc960350fc19800920e3067b84142545824c62a594ef7acc57984'
  checksumType   = 'sha256'
  url            = 'https://files.freeciv.org/packages/windows/Freeciv-3.2.7-msys2-win64-10-gtk3.22-setup.exe'

  silentArgs     = '/S'
  validExitCodes = @(0)
}

Install-ChocolateyPackage @packageArgs
