$ErrorActionPreference = 'Stop';

$packageArgs = @{
  packageName    = 'wesnoth'
  fileType       = 'exe'
  url            = 'https://sourceforge.net/projects/wesnoth/files/wesnoth/wesnoth-1.17.5/wesnoth-1.17.5-win64.exe/download'
  softwareName   = 'Battle for Wesnoth*'
  checksum       = '3ac4ac6cff769b3143b23f91ca182c763a2c4cfc9969fe0a51e74053ba15d63f'
  checksumType   = 'sha256'
  silentArgs     = '/S'
  validExitCodes = @(0)
}

Install-ChocolateyPackage @packageArgs
