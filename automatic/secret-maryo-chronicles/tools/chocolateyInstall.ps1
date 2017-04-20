$ErrorActionPreference = 'Stop';

$packageArgs = @{
  packageName    = 'secret-maryo-chronicles'
  fileType       = 'exe'
  url            = ''
  softwareName   = '*'
  checksum       = ''
  checksumType   = ''
  silentArgs     = '/S'
  validExitCodes = @(0)
}

Install-ChocolateyPackage @packageArgs
