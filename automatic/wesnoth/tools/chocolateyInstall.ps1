$ErrorActionPreference = 'Stop';

$packageArgs = @{
  packageName    = 'wesnoth'
  fileType       = 'exe'
  url            = 'https://sourceforge.net/projects/wesnoth/files/wesnoth/wesnoth-1.15.17/wesnoth-1.15.17-win64.exe/download'
  softwareName   = 'Battle for Wesnoth*'
  checksum       = '9edd48dbf9b8ef15acc42abf7d1b5b50a5fec2b7254dda9003207d0ab45c858c'
  checksumType   = 'sha256'
  silentArgs     = '/S'
  validExitCodes = @(0)
}

Install-ChocolateyPackage @packageArgs
