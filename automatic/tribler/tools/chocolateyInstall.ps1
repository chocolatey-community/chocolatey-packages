$ErrorActionPreference = 'Stop';

$packageName  = 'tribler'
$url          = 'https://github.com/Tribler/tribler/releases/download/v7.0.0-rc5/Tribler_7.0.0-rc5_x64.exe'
$checksum     = '8d1786acd970561dfa9c3931eec24abde1f3ff1f0c9a3626b12f573b260cf698'
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
