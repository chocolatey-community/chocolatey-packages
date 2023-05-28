$ErrorActionPreference = 'Stop';

$packageArgs = @{
  packageName    = 'wesnoth'
  fileType       = 'exe'
  url            = 'https://sourceforge.net/projects/wesnoth/files/wesnoth/wesnoth-1.17.17/wesnoth-1.17.17-win64.exe/download'
  softwareName   = 'Battle for Wesnoth*'
  checksum       = '35c128b77f15b2f01026d4e58a4e7d3c5d7da9dd47bbc3e9f7d04494c77bdf7b'
  checksumType   = 'sha256'
  silentArgs     = '/S'
  validExitCodes = @(0)
}

Install-ChocolateyPackage @packageArgs
