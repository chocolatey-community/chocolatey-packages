$ErrorActionPreference = 'Stop';

$packageArgs = @{
  packageName    = 'wesnoth'
  fileType       = 'exe'
  url            = 'https://sourceforge.net/projects/wesnoth/files/wesnoth/wesnoth-1.17.13/wesnoth-1.17.13-win64.exe/download'
  softwareName   = 'Battle for Wesnoth*'
  checksum       = 'd7267c5a4016e93b4014b8c26c71660b1b30cba5954d1c0d1244d629963e6918'
  checksumType   = 'sha256'
  silentArgs     = '/S'
  validExitCodes = @(0)
}

Install-ChocolateyPackage @packageArgs
