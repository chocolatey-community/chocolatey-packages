$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  url            = 'https://cdn.gomlab.com/gretech/player/new/GOMPLAYERGLOBALSETUP.EXE'
  softwareName   = 'GOM Player'
  checksum       = '5f36c373ad830fdc8bd813d2265f9f20377a4fae0de57dcba537b90d18698145'
  checksumType   = 'sha256'
  silentArgs     = '/S'
  validExitCodes = @(0)
}

Install-ChocolateyPackage @packageArgs
