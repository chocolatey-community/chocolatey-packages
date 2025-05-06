$ErrorActionPreference = 'Stop';

$packageArgs = @{
  packageName    = 'wesnoth'
  fileType       = 'exe'
  url            = 'https://sourceforge.net/projects/wesnoth/files/wesnoth/wesnoth-1.19.11/wesnoth-1.19.11-win64.exe/download'
  softwareName   = 'Battle for Wesnoth*'
  checksum       = '54e82026505108c48f9cebe8e17c7d2f6abd00ce9a9bf3bcd65bff77e927aae8'
  checksumType   = 'sha256'
  silentArgs     = '/S'
  validExitCodes = @(0)
}

Install-ChocolateyPackage @packageArgs
