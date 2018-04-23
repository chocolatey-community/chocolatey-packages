$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  softwareName   = 'Skype*'
  url            = ''
  checksum       = ''
  checksumType   = ''
  silentArgs     = '/qn /norestart STARTSKYPE=FALSE TRANSFORMS=:RemoveDesktopShortcut.mst TRANSFORMS=:RemoveStartup.mst'
  validExitCodes = @(0)
}

Install-ChocolateyPackage @packageArgs
