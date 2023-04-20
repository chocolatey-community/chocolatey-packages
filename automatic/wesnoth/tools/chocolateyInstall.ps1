$ErrorActionPreference = 'Stop';

$packageArgs = @{
  packageName    = 'wesnoth'
  fileType       = 'exe'
  url            = 'https://sourceforge.net/projects/wesnoth/files/wesnoth-1.16/wesnoth-1.16.9/wesnoth-1.16.9-win64.exe/download'
  softwareName   = 'Battle for Wesnoth*'
  checksum       = '6c2b68d6bfb7ce823dd93d8dd4b5aa665ce03d2d8ddacd3007aa1549d931a884'
  checksumType   = 'sha256'
  silentArgs     = '/S'
  validExitCodes = @(0)
}

Install-ChocolateyPackage @packageArgs
