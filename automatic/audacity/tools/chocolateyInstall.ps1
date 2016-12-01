$ErrorActionPreference = 'Stop'

$packageName = 'audacity'
$url32 = Get-UrlFromFosshub 'https://www.fosshub.com/Audacity.html/audacity-win-2.1.2.exe'
$checksum32  = '22e0f0ada3e8d24690dd741ca9feb868dffc024d45d2cd3168f8c54c47eec3c9'

$packageArgs = @{
  packageName    = $packageName
  fileType       = 'exe'
  url            = $url32
  options        = @{ Headers = @{ Referer = 'https://www.fosshub.com/' } }
  checksum       = $checksum32
  checksumType   = 'sha256'
  silentArgs     = '/VERYSILENT'
  validExitCodes = @(0)
}

Install-ChocolateyPackage @packageArgs
