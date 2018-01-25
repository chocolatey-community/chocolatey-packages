$ErrorActionPreference = 'Stop';

$packageName  = 'tribler'
$url          = 'https://github.com/Tribler/tribler/releases/download/v7.0.0/Tribler_7.0.0_x64.exe'
$checksum     = '2d5c6b02e7e787ad7ee62f8d638ef69a075b27cc30732727a922dc8ec099f733'
$checksumType = 'sha256'

$packageArgs = @{
  packageName    = $packageName
  fileType       = 'exe'
  softwareName   = 'Tribler'

  checksum       = $checksum
  checksumType   = $checksumType
  url            = $url

  silentArgs     = '/S'
  validExitCodes = @(0, 1223)
}

Install-ChocolateyPackage @packageArgs
