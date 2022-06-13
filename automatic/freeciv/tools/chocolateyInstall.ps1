$ErrorActionPreference = 'Stop';

$packageArgs = @{
  packageName    = 'freeciv'
  fileType       = 'exe'
  softwareName   = 'Freeciv*'

  checksum       = '6f3234eeb41350479523ae851e1f93d0efd715ebfbc5645ff40fbf6d1a2285ca'
  checksumType   = 'sha256'
  url            = 'http://files.freeciv.org/packages/windows/Freeciv-3.0.2-msys2-win64-gtk3.22-setup.exe'

  silentArgs     = '/S'
  validExitCodes = @(0)
}

Install-ChocolateyPackage @packageArgs
