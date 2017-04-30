$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName    = 'owncloud-client'
  fileType       = 'exe'
  softwareName   = 'ownCloud'

  checksum       = '8a9d1cd2e218e91aaae6d1737a2451bb402625a7240977e2ce6ac00067d0cc1c'
  checksumType   = 'sha256'
  url            = 'https://download.owncloud.com/desktop/stable/ownCloud-2.3.1.6824-setup.exe'

  silentArgs     = '/S'
  validExitCodes = @(0)
}

Install-ChocolateyPackage @packageArgs
