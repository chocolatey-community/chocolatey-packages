$ErrorActionPreference = 'Stop';

$packageArgs = @{
  packageName    = 'freeciv'
  fileType       = 'exe'
  softwareName   = 'Freeciv*'

  checksum       = 'da04bdad593e452f3d31dcbc9539be91bbeff9f13e27a46a55d290674a74e34a'
  checksumType   = 'sha256'
  url            = 'https://files.freeciv.org/packages/windows/Freeciv-3.0.9-msys2-win64-gtk3.22-setup.exe'

  silentArgs     = '/S'
  validExitCodes = @(0)
}

Install-ChocolateyPackage @packageArgs
