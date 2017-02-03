$ErrorActionPreference = 'Stop';

$packageArgs = @{
  packageName    = 'wesnoth'
  fileType       = 'exe'
  url            = 'https://sourceforge.net/projects/wesnoth/files/wesnoth-1.12/wesnoth-1.12.6/wesnoth-1.12.6-win32.exe/download'
  softwareName   = 'Battle for Wesnoth*'
  checksum       = '340a045deafcc236d2e00cb47598b4a5e8d656463270a3433ed637108916db71'
  checksumType   = 'sha256'
  silentArgs     = '/S'
  validExitCodes = @(0)
}

Install-ChocolateyPackage @packageArgs
