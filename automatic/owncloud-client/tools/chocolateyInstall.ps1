$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName    = 'owncloud-client'
  fileType       = 'exe'
  softwareName   = 'ownCloud'

  checksum       = '8620ee6727f086ac822b6c137619bac97ad6e39fc812119fc2876985b83cce6b'
  checksumType   = 'sha256'
  url            = 'https://download.owncloud.com/desktop/stable/ownCloud-2.2.4.6408-setup.exe'

  silentArgs     = '/S'
  validExitCodes = @(0)
}

Install-ChocolateyPackage @packageArgs
