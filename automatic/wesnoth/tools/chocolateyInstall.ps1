$ErrorActionPreference = 'Stop';

$packageArgs = @{
  packageName    = 'wesnoth'
  fileType       = 'exe'
  url            = 'https://sourceforge.net/projects/wesnoth/files/wesnoth-1.16/wesnoth-1.16.11/wesnoth-1.16.11-win64.exe/download'
  softwareName   = 'Battle for Wesnoth*'
  checksum       = '015433c95d27dace3ed9af71523d8c40d0130be44ea38143a91474848d89b5ae'
  checksumType   = 'sha256'
  silentArgs     = '/S'
  validExitCodes = @(0)
}

Install-ChocolateyPackage @packageArgs
