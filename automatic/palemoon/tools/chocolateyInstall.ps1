$ErrorActionPreference = 'Stop';

$packageArgs = @{
  packageName   = 'palemoon'
  fileType      = 'exe'
  url           = 'https://rm-eu.palemoon.org/release/palemoon-28.8.1.win32.installer.exe'
  url64         = 'https://rm-eu.palemoon.org/release/palemoon-28.8.1.win64.installer.exe'

  softwareName  = 'Pale Moon*'

  checksum      = '88ede6eae369803b5f1fba2660861182e4edfe2583259ed0163dc468d5ca1d8f'
  checksumType  = 'sha256'
  checksum64    = 'e3347e0adc121417c8ab2ae1fdf903306d484deb64bd95c399ebe19e070c7046'
  checksumType64= 'sha256'

  silentArgs    = "/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-"
  validExitCodes= @(0)
}

Install-ChocolateyPackage @packageArgs
