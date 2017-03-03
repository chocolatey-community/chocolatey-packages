$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName    = 'owncloud-client'
  fileType       = 'exe'
  softwareName   = 'ownCloud'

  checksum       = '62fa7d75febaedba236dda2b10b48e1280dc71de951dbff089aea1c6aeeb7413'
  checksumType   = 'sha256'
  url            = 'https://download.owncloud.com/desktop/stable/ownCloud-2.3.0.6780-setup.exe'

  silentArgs     = '/S'
  validExitCodes = @(0)
}

Install-ChocolateyPackage @packageArgs
