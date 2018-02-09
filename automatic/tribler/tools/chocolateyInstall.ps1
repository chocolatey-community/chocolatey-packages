$ErrorActionPreference = 'Stop';

$packageName  = 'tribler'
$url          = 'https://github.com/Tribler/tribler/releases/download/v7.0.1/Tribler_7.0.1_x64.exe'
$checksum     = 'f0f1926587826e20d5dd7a3d11d7ded08abdf30ee31839d760ab9c89580bc92a'
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
