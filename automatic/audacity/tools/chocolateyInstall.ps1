$ErrorActionPreference = 'Stop'

$packageName = 'audacity'
$checksum32  = '22e0f0ada3e8d24690dd741ca9feb868dffc024d45d2cd3168f8c54c47eec3c9'

$packageArgs = @{
  packageName    = $packageName
  fileType       = 'exe'
  url            = 'https://www.fosshub.com/Audacity.html/audacity-win-2.1.2.exe'
  checksum       = $checksum32
  checksumType   = 'sha256'
  silentArgs     = '/VERYSILENT'
  validExitCodes = @(0)
}

Install-ChocolateyFosshub @packageArgs
