$ErrorActionPreference = 'Stop';

$packageArgs = @{
  packageName    = 'wesnoth'
  fileType       = 'exe'
  url            = 'https://sourceforge.net/projects/wesnoth/files/wesnoth/wesnoth-1.19.4/wesnoth-1.19.4-win64.exe/download'
  softwareName   = 'Battle for Wesnoth*'
  checksum       = '16bd40a8a636915280298f6ce82183473bcd93e0951f30ceaf6e18825f4cb228'
  checksumType   = 'sha256'
  silentArgs     = '/S'
  validExitCodes = @(0)
}

Install-ChocolateyPackage @packageArgs
