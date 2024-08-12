$ErrorActionPreference = 'Stop';

$packageArgs = @{
  packageName    = 'wesnoth'
  fileType       = 'exe'
  url            = 'https://sourceforge.net/projects/wesnoth/files/wesnoth-1.18/wesnoth-1.18.2/wesnoth-1.18.2-win64.exe/download'
  softwareName   = 'Battle for Wesnoth*'
  checksum       = '3a83338eb85c9b9d6e7985c1c0bb9fdf59594fe04c72e261c4290ce9f586e0f6'
  checksumType   = 'sha256'
  silentArgs     = '/S'
  validExitCodes = @(0)
}

Install-ChocolateyPackage @packageArgs
