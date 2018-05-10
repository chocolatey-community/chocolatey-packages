$ErrorActionPreference = 'Stop';

$packageArgs = @{
  packageName    = 'wesnoth'
  fileType       = 'exe'
  url            = 'https://sourceforge.net/projects/wesnoth/files/wesnoth-1.14/wesnoth-1.14.1/wesnoth-1.14.1-win32.exe/download'
  softwareName   = 'Battle for Wesnoth*'
  checksum       = '38d6a3bc7b5005a78980ae4c8341ab682fc6997e7a4e56b07562844ebb6326ef'
  checksumType   = 'sha256'
  silentArgs     = '/S'
  validExitCodes = @(0)
}

Install-ChocolateyPackage @packageArgs
