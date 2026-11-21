$ErrorActionPreference = 'Stop'

$packageName = 'scsdrive'

$packageArgs = @{
  packageName    = $packageName
  fileType       = 'exe'
  softwareName   = 'ScsDrive*'
  silentArgs     = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART'
  validExitCodes = @(0)
}

Install-ChocolateyInstallPackage @packageArgs
