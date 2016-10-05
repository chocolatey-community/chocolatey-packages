$ErrorActionPreference = 'Stop'

$url = Get-UrlFromFosshub "https://www.fosshub.com/Audacity.html/audacity-win-2.1.2.exe"

$packageArgs = @{
  packageName    = 'audacity'
  fileType       = 'exe'
  url            = $url
  checksum       = '22E0F0ADA3E8D24690DD741CA9FEB868DFFC024D45D2CD3168F8C54C47EEC3C9'
  checksumType   = 'sha256'
  silentArgs     = '/VERYSILENT'
  validExitCodes = @(0)
}

Install-ChocolateyPackage @packageArgs
