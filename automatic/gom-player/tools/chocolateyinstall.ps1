$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  url            = 'https://cdn.gomlab.com/gretech/player/GOMPLAYERGLOBALSETUP_NEW.EXE'
  softwareName   = 'GOM Player'
  checksum       = '2d0b9c8f6211ef89a13e419ea8ccf6c6d4a6f72bd1459dfc6cec626bc88caf69'
  checksumType   = 'sha256'
  silentArgs     = '/S'
  validExitCodes = @(0)
}

Install-ChocolateyPackage @packageArgs
