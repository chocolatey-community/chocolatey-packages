$ErrorActionPreference = 'Stop'

$packageArgs  = @{
  packageName    = $env:chocolateyPackageName
  fileType       = 'exe'
  softwareName   = 'Ant Renamer'

  checksum       = ''
  checksumType   = ''
  url            = ''

  silentArgs     = '/VERYSILENT'
  validExitCodes = @(0)
}

Install-ChocolateyPackage @packageArgs
