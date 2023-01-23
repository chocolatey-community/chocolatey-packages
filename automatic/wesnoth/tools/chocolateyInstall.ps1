$ErrorActionPreference = 'Stop';

$packageArgs = @{
  packageName    = 'wesnoth'
  fileType       = 'exe'
  url            = 'https://sourceforge.net/projects/wesnoth/files/wesnoth-1.16/wesnoth-1.16.8/wesnoth-1.16.8-win64.exe/download'
  softwareName   = 'Battle for Wesnoth*'
  checksum       = '8f298d43c2a8608050c084f705271fab5ea4d7393543bfaf5225a71884176675'
  checksumType   = 'sha256'
  silentArgs     = '/S'
  validExitCodes = @(0)
}

Install-ChocolateyPackage @packageArgs
