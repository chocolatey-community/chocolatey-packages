$ErrorActionPreference = 'Stop';

$packageArgs = @{
  packageName    = 'wesnoth'
  fileType       = 'exe'
  url            = 'https://sourceforge.net/projects/wesnoth/files/wesnoth/wesnoth-1.15.5/wesnoth-1.15.5-win64.exe/download'
  softwareName   = 'Battle for Wesnoth*'
  checksum       = '082c1acd50a0c0522aace1da0d399e152969f84538821910893e17e37ed41cb0'
  checksumType   = 'sha256'
  silentArgs     = '/S'
  validExitCodes = @(0)
}

Install-ChocolateyPackage @packageArgs
