$ErrorActionPreference = 'Stop';

$packageArgs = @{
  packageName    = 'wesnoth'
  fileType       = 'exe'
  url            = 'https://sourceforge.net/projects/wesnoth/files/wesnoth/wesnoth-1.19.16/wesnoth-1.19.16-win64.exe/download'
  softwareName   = 'Battle for Wesnoth*'
  checksum       = '4b52b3546c9c0d625058b60b018c967fdb793a04cf4700bc18388bb97f174907'
  checksumType   = 'sha256'
  silentArgs     = '/S'
  validExitCodes = @(0)
}

Install-ChocolateyPackage @packageArgs
