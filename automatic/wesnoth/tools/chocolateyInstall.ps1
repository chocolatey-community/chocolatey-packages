$ErrorActionPreference = 'Stop';

$packageArgs = @{
  packageName    = 'wesnoth'
  fileType       = 'exe'
  url            = 'https://sourceforge.net/projects/wesnoth/files/wesnoth-1.18/wesnoth-1.18.0/wesnoth-1.18.0-win64.exe/download'
  softwareName   = 'Battle for Wesnoth*'
  checksum       = '5920aaa24828ff9048f59bed49ab1ba670209333aa114a98d1643a88cfc7c7f8'
  checksumType   = 'sha256'
  silentArgs     = '/S'
  validExitCodes = @(0)
}

Install-ChocolateyPackage @packageArgs
