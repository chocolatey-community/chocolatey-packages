$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName    = 'owncloud-client'
  fileType       = 'exe'
  softwareName   = 'ownCloud'

  checksum       = '7c7e626f2a9c443501ede5811927fe8bff81aad3bcf684461f3b1420aa32f14f'
  checksumType   = 'sha256'
  url            = 'https://download.owncloud.com/desktop/stable/ownCloud-2.3.4.8624-setup.exe'

  silentArgs     = '/S'
  validExitCodes = @(0)
}

Install-ChocolateyPackage @packageArgs
