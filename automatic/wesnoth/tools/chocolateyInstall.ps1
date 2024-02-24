$ErrorActionPreference = 'Stop';

$packageArgs = @{
  packageName    = 'wesnoth'
  fileType       = 'exe'
  url            = 'https://sourceforge.net/projects/wesnoth/files/wesnoth/wesnoth-1.17.26/wesnoth-1.17.26-win64.exe/download'
  softwareName   = 'Battle for Wesnoth*'
  checksum       = 'c497b4daa7598e955ca26390924e4180a1aaea86f8973477cb7f95009bff114e'
  checksumType   = 'sha256'
  silentArgs     = '/S'
  validExitCodes = @(0)
}

Install-ChocolateyPackage @packageArgs
