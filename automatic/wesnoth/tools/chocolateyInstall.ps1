$ErrorActionPreference = 'Stop';

$packageArgs = @{
  packageName    = 'wesnoth'
  fileType       = 'exe'
  url            = 'https://sourceforge.net/projects/wesnoth/files/wesnoth/wesnoth-1.19.17/wesnoth-1.19.17-win64.exe/download'
  softwareName   = 'Battle for Wesnoth*'
  checksum       = '3043cf6db1dcd17c341ee8af7d625a9d561cc06fbf091297a0aa6d3f413b21bb'
  checksumType   = 'sha256'
  silentArgs     = '/S'
  validExitCodes = @(0)
}

Install-ChocolateyPackage @packageArgs
