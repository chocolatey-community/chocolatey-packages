$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  url            = 'https://app.gomtv.com/gom/GOMPLAYERKORSETUP.EXE'
  softwareName   = 'GOM Player'
  checksum       = 'b0a8489d8959c6a3fa96b6eae03edd24c0a4c49c0a92c6983d95ffda800651ee'
  checksumType   = 'sha256'
  silentArgs     = '/S'
  validExitCodes = @(0)
}

Install-ChocolateyPackage @packageArgs
