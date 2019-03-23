$ErrorActionPreference = 'Stop';

$packageArgs = @{
  packageName    = 'wesnoth'
  fileType       = 'exe'
  url            = 'https://sourceforge.net/projects/wesnoth/files/wesnoth-1.14/wesnoth-1.14.6/wesnoth-1.14.6-win32.exe/download'
  softwareName   = 'Battle for Wesnoth*'
  checksum       = '0741a229e1a7da84392b7ce6424fdca3ccb0d84588ac86233d64f4102dfb973e'
  checksumType   = 'sha256'
  silentArgs     = '/S'
  validExitCodes = @(0)
}

Install-ChocolateyPackage @packageArgs
