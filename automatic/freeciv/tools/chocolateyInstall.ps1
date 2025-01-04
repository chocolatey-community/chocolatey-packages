$ErrorActionPreference = 'Stop';

$packageArgs = @{
  packageName    = 'freeciv'
  fileType       = 'exe'
  softwareName   = 'Freeciv*'

  checksum       = '2b0232257a507c48e658cd9d1b118587b1d68f0a052d3fd9c65104352b55c485'
  checksumType   = 'sha256'
  url            = 'https://files.freeciv.org/packages/windows/Freeciv-3.1.4-msys2-win64-10-gtk3.22-setup.exe'

  silentArgs     = '/S'
  validExitCodes = @(0)
}

Install-ChocolateyPackage @packageArgs
