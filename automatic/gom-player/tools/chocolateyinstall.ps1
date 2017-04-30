$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  url            = 'https://cdn.gomlab.com/gretech/player/new/GOMPLAYERGLOBALSETUP.EXE'
  softwareName   = 'GOM Player'
  checksum       = '033e11cfff19b8a614160bc0bae5d096b2ae0432e46d67951abeffc0eda60f0c'
  checksumType   = 'sha256'
  silentArgs     = '/S'
  validExitCodes = @(0)
}

Install-ChocolateyPackage @packageArgs
