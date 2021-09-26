$ErrorActionPreference = 'Stop';

$packageArgs = @{
  packageName    = 'wesnoth'
  fileType       = 'exe'
  url            = 'https://sourceforge.net/projects/wesnoth/files/wesnoth/wesnoth-1.15.18/wesnoth-1.15.18-win64.exe/download'
  softwareName   = 'Battle for Wesnoth*'
  checksum       = '1c0ee8f5433482f8b2bb4045eb45cc20e0b30a0e7e33be285dc77b6d256f3f2e'
  checksumType   = 'sha256'
  silentArgs     = '/S'
  validExitCodes = @(0)
}

Install-ChocolateyPackage @packageArgs
