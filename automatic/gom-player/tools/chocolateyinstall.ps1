$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  url            = 'https://app.gomtv.com/gom/GOMPLAYERKORSETUP.EXE'
  softwareName   = 'GOM Player'
  checksum       = '9d350fc60909a9cbdc89c09b9be9ae0bfe72479ac369ce9af948812e7d0f51dc'
  checksumType   = 'sha256'
  silentArgs     = '/S'
  validExitCodes = @(0)
}

Install-ChocolateyPackage @packageArgs
