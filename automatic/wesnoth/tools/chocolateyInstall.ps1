$ErrorActionPreference = 'Stop';

$packageArgs = @{
  packageName    = 'wesnoth'
  fileType       = 'exe'
  url            = 'https://sourceforge.net/projects/wesnoth/files/wesnoth/wesnoth-1.19.21/wesnoth-1.19.21-win64.exe/download'
  softwareName   = 'Battle for Wesnoth*'
  checksum       = '7492d586fa192b5d60dfbc4265567e344993401aed6a63d03dc53db130cbbcbb'
  checksumType   = 'sha256'
  silentArgs     = '/S'
  validExitCodes = @(0)
}

Install-ChocolateyPackage @packageArgs
