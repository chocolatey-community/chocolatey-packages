$ErrorActionPreference = 'Stop';

$packageArgs = @{
  packageName    = 'wesnoth'
  fileType       = 'exe'
  url            = 'https://sourceforge.net/projects/wesnoth/files/wesnoth-1.18/wesnoth-1.18.8/wesnoth-1.18.8-win64.exe/download'
  softwareName   = 'Battle for Wesnoth*'
  checksum       = '464a2edfce8a0fe08e9956a363785938970254ee385672388bb8ba3556d8a09c'
  checksumType   = 'sha256'
  silentArgs     = '/S'
  validExitCodes = @(0)
}

Install-ChocolateyPackage @packageArgs
