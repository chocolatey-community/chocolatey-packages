$ErrorActionPreference = 'Stop';

$packageArgs = @{
  packageName    = 'wesnoth'
  fileType       = 'exe'
  url            = 'https://sourceforge.net/projects/wesnoth/files/wesnoth/wesnoth-1.17.2/wesnoth-1.17.2-win64.exe/download'
  softwareName   = 'Battle for Wesnoth*'
  checksum       = 'cbdf5406416917871cd4eba9214a0393c5b772b2f9b1db3cdb9183ff19021db1'
  checksumType   = 'sha256'
  silentArgs     = '/S'
  validExitCodes = @(0)
}

Install-ChocolateyPackage @packageArgs
