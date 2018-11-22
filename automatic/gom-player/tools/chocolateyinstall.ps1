$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  url            = 'https://cdn.gomlab.com/gretech/player/GOMPLAYERGLOBALSETUP_CHROME.EXE'
  softwareName   = 'GOM Player'
  checksum       = '51fc40d20f00a0113de8df449bf197c47bb4af06ecbf8f3ad851a4b90d4daad3'
  checksumType   = 'sha256'
  silentArgs     = '/S'
  validExitCodes = @(0)
}

Install-ChocolateyPackage @packageArgs
