$ErrorActionPreference = 'Stop';

$packageArgs = @{
  packageName    = 'wesnoth'
  fileType       = 'exe'
  url            = 'https://sourceforge.net/projects/wesnoth/files/wesnoth/wesnoth-1.13.11/wesnoth-1.13.11-win32.exe/download'
  softwareName   = 'Battle for Wesnoth*'
  checksum       = '9c281d37486de24b606a1aed7b3034d8796f22ce645d7bee843d63f89ccff053'
  checksumType   = 'sha256'
  silentArgs     = '/S'
  validExitCodes = @(0)
}

Install-ChocolateyPackage @packageArgs
