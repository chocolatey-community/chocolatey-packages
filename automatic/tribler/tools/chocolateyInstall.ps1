$ErrorActionPreference = 'Stop';

$packageName  = 'tribler'
$url          = 'https://github.com/Tribler/tribler/releases/download/v7.0.2/Tribler_7.0.2_x64.exe'
$checksum     = 'd25470c7c4ce45eeddcd40301464e17238dd7020c69d5b35af0f76e21b978601'
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
