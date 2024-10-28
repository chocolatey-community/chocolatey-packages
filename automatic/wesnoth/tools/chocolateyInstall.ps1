$ErrorActionPreference = 'Stop';

$packageArgs = @{
  packageName    = 'wesnoth'
  fileType       = 'exe'
  url            = 'https://sourceforge.net/projects/wesnoth/files/wesnoth/wesnoth-1.19.5/wesnoth-1.19.5-win64.exe/download'
  softwareName   = 'Battle for Wesnoth*'
  checksum       = '1160d5fc937708e78f8423c8126e53fe2269345dedb48f177e86c041c9766602'
  checksumType   = 'sha256'
  silentArgs     = '/S'
  validExitCodes = @(0)
}

Install-ChocolateyPackage @packageArgs
