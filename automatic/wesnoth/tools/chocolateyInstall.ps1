$ErrorActionPreference = 'Stop';

$packageArgs = @{
  packageName    = 'wesnoth'
  fileType       = 'exe'
  url            = 'https://sourceforge.net/projects/wesnoth/files/wesnoth/wesnoth-1.17.18/wesnoth-1.17.18-win64.exe/download'
  softwareName   = 'Battle for Wesnoth*'
  checksum       = '9027c226be358862fafc46bf744f355b4eab5632051534722c6bdc9155cf565d'
  checksumType   = 'sha256'
  silentArgs     = '/S'
  validExitCodes = @(0)
}

Install-ChocolateyPackage @packageArgs
