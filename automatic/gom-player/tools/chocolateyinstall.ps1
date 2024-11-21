$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  url            = 'https://app.gomtv.com/gom/GOMPLAYERKORSETUP.EXE'
  softwareName   = 'GOM Player'
  checksum       = '74995f1e29aed0c989373a95e3055de394a92536f3c5600d0ce14b8b64ac65c8'
  checksumType   = 'sha256'
  silentArgs     = '/S'
  validExitCodes = @(0)
}

Install-ChocolateyPackage @packageArgs
