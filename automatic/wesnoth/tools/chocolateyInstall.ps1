$ErrorActionPreference = 'Stop';

$packageArgs = @{
  packageName    = 'wesnoth'
  fileType       = 'exe'
  url            = 'https://sourceforge.net/projects/wesnoth/files/wesnoth-1.14/wesnoth-1.14.17/wesnoth-1.14.17-win32.exe/download'
  softwareName   = 'Battle for Wesnoth*'
  checksum       = '6886359657503cb55e3f8e5c03fe559faa5f02a93a825852b4ff6ad081f1989f'
  checksumType   = 'sha256'
  silentArgs     = '/S'
  validExitCodes = @(0)
}

Install-ChocolateyPackage @packageArgs
