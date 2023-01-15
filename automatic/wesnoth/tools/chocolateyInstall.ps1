$ErrorActionPreference = 'Stop';

$packageArgs = @{
  packageName    = 'wesnoth'
  fileType       = 'exe'
  url            = 'https://sourceforge.net/projects/wesnoth/files/wesnoth-1.16/wesnoth-1.16.7/wesnoth-1.16.7-win64.exe/download'
  softwareName   = 'Battle for Wesnoth*'
  checksum       = '640a9a250de7b118e27bc0b2ede7e22d31367d0273f9219eca56414124a58baa'
  checksumType   = 'sha256'
  silentArgs     = '/S'
  validExitCodes = @(0)
}

Install-ChocolateyPackage @packageArgs
