$ErrorActionPreference = 'Stop';

$packageName  = 'tribler'
$url          = 'https://github.com/Tribler/tribler/releases/download/v6.5.2/Tribler_6.5.2.exe'
$checksum     = '077cbe7d16639f469c1a7dfc994d0e9c298e1e5663b75500ee41e38b28c48257'
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
