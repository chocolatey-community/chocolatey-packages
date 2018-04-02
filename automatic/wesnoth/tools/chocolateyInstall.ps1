$ErrorActionPreference = 'Stop';

$packageArgs = @{
  packageName    = 'wesnoth'
  fileType       = 'exe'
  url            = 'https://sourceforge.net/projects/wesnoth/files/wesnoth/wesnoth-1.13.13/wesnoth-1.13.13-win32.exe/download'
  softwareName   = 'Battle for Wesnoth*'
  checksum       = '9524b5f1ccc45b043ff26f5d0535dfdf6745126bb71ee2980c4c75a9023772fe'
  checksumType   = 'sha256'
  silentArgs     = '/S'
  validExitCodes = @(0)
}

Install-ChocolateyPackage @packageArgs
