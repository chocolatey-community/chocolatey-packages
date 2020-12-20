$ErrorActionPreference = 'Stop';

$packageArgs = @{
  packageName    = 'wesnoth'
  fileType       = 'exe'
  url            = 'https://sourceforge.net/projects/wesnoth/files/wesnoth-1.14/wesnoth-1.14.15/wesnoth-1.14.15-win32.exe/download'
  softwareName   = 'Battle for Wesnoth*'
  checksum       = '0af0a86bac4f93a3b2d5f9ee414866821462420672b80a8e222b45b3f21f10c5'
  checksumType   = 'sha256'
  silentArgs     = '/S'
  validExitCodes = @(0)
}

Install-ChocolateyPackage @packageArgs
