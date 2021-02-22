$ErrorActionPreference = 'Stop';

$packageArgs = @{
  packageName    = 'wesnoth'
  fileType       = 'exe'
  url            = 'https://sourceforge.net/projects/wesnoth/files/wesnoth/wesnoth-1.15.10/wesnoth-1.15.10-win64.exe/download'
  softwareName   = 'Battle for Wesnoth*'
  checksum       = 'ea2e47d42ea809e3ab35e8d445e9c4a42901abc76e2f7ee7a2825cbd4137b88f'
  checksumType   = 'sha256'
  silentArgs     = '/S'
  validExitCodes = @(0)
}

Install-ChocolateyPackage @packageArgs
