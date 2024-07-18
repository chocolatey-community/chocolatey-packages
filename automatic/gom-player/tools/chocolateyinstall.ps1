$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  url            = 'https://app.gomtv.com/gom/GOMPLAYERKORSETUP.EXE'
  softwareName   = 'GOM Player'
  checksum       = 'b567c096845532e9020bee098e1e1e0a5fc016984bff3e64db8eeb411e13d081'
  checksumType   = 'sha256'
  silentArgs     = '/S'
  validExitCodes = @(0)
}

Install-ChocolateyPackage @packageArgs
