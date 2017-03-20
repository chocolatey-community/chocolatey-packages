$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  url            = 'https://cdn.gomlab.com/gretech/player/new/GOMPLAYERGLOBALSETUP.EXE'
  softwareName   = 'GOM Player'
  checksum       = '681e8c6aaa097b4f38662bc2cbc56d5b75b522d109059663b1f00afef67659de'
  checksumType   = 'sha256'
  silentArgs     = '/S'
  validExitCodes = @(0)
}

Install-ChocolateyPackage @packageArgs
