$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  url            = 'https://cdn.gomlab.com/gretech/player/GOMPLAYERGLOBALSETUP_NEW.EXE'
  softwareName   = 'GOM Player'
  checksum       = '9a2755687533d48f7aff2ea30330785cd337b0e022bdf22f0fbc5ff31c8da3e8'
  checksumType   = 'sha256'
  silentArgs     = '/S'
  validExitCodes = @(0)
}

Install-ChocolateyPackage @packageArgs
