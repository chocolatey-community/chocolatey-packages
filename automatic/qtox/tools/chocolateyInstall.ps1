$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName    = 'qtox'
  fileType       = 'exe'
  softwareName   = 'qTox'

  checksum       = ''
  checksum64     = ''
  checksumType   = ''
  checksumType64 = ''
  url            = ''
  url64          = ''

  silentArgs     = '/S'
  validExitCodes = @(0)
}

Install-ChocolateyPackage @packageArgs
