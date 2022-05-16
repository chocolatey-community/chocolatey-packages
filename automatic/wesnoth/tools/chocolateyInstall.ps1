$ErrorActionPreference = 'Stop';

$packageArgs = @{
  packageName    = 'wesnoth'
  fileType       = 'exe'
  url            = 'https://sourceforge.net/projects/wesnoth/files/wesnoth/wesnoth-1.17.4/wesnoth-1.17.4-win64.exe/download'
  softwareName   = 'Battle for Wesnoth*'
  checksum       = 'b1a2822ae0763426ce52026b07c438c786203ce580db460b92d5edcdcabe6b8c'
  checksumType   = 'sha256'
  silentArgs     = '/S'
  validExitCodes = @(0)
}

Install-ChocolateyPackage @packageArgs
