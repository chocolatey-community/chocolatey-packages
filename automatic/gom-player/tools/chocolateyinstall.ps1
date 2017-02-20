$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  url            = 'https://cdn.gomlab.com/gretech/player/new/GOMPLAYERGLOBALSETUP.EXE'
  softwareName   = 'GOM Player'
  checksum       = '986897c04784a1bf0746fb95312a1b83d498ee48459d35980eaf6117e2454f30'
  checksumType   = 'sha256'
  silentArgs     = '/S'
  validExitCodes = @(0)
}

Install-ChocolateyPackage @packageArgs
