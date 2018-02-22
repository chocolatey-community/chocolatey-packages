$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  url            = 'https://cdn.gomlab.com/gretech/player/GOMPLAYERGLOBALSETUP_NEW.EXE'
  softwareName   = 'GOM Player'
  checksum       = '7f2a43f7a083d77b8ecd1d2241f1f08e367b98afcf7bd0a6086075ea2f078760'
  checksumType   = 'sha256'
  silentArgs     = '/S'
  validExitCodes = @(0)
}

Install-ChocolateyPackage @packageArgs
