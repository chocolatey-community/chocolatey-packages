$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  url            = 'https://cdn.gomlab.com/gretech/player/GOMPLAYERGLOBALSETUP_CHROME.EXE'
  softwareName   = 'GOM Player'
  checksum       = '39693072f3410b1f54f0eb70dde3c4991a2584c751bc7082f230d9027de5c45f'
  checksumType   = 'sha256'
  silentArgs     = '/S'
  validExitCodes = @(0)
}

Install-ChocolateyPackage @packageArgs
