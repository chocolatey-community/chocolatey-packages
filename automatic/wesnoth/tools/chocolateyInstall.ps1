$ErrorActionPreference = 'Stop';

$packageArgs = @{
  packageName    = 'wesnoth'
  fileType       = 'exe'
  url            = 'https://sourceforge.net/projects/wesnoth/files/wesnoth/wesnoth-1.13.14/wesnoth-1.13.14-win32.exe/download'
  softwareName   = 'Battle for Wesnoth*'
  checksum       = 'f490f86459e6a95fc92fb44b9b0ab94245e22047f72176cc53cfb75466e04013'
  checksumType   = 'sha256'
  silentArgs     = '/S'
  validExitCodes = @(0)
}

Install-ChocolateyPackage @packageArgs
