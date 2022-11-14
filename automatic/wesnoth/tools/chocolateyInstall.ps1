$ErrorActionPreference = 'Stop';

$packageArgs = @{
  packageName    = 'wesnoth'
  fileType       = 'exe'
  url            = 'https://sourceforge.net/projects/wesnoth/files/wesnoth/wesnoth-1.17.9/wesnoth-1.17.9-win64.exe/download'
  softwareName   = 'Battle for Wesnoth*'
  checksum       = '4c093f1325199a6986429bbb7979b00955226409c9cc553999f0f5e19b1c33a1'
  checksumType   = 'sha256'
  silentArgs     = '/S'
  validExitCodes = @(0)
}

Install-ChocolateyPackage @packageArgs
