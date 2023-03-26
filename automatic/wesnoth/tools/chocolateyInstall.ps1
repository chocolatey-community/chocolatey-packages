$ErrorActionPreference = 'Stop';

$packageArgs = @{
  packageName    = 'wesnoth'
  fileType       = 'exe'
  url            = 'https://sourceforge.net/projects/wesnoth/files/wesnoth/wesnoth-1.17.14/wesnoth-1.17.14-win64.exe/download'
  softwareName   = 'Battle for Wesnoth*'
  checksum       = 'ac3d2ef760ca8dbb0ea7583e549b91cb804de8c7e29afd16547580c53ce1b59d'
  checksumType   = 'sha256'
  silentArgs     = '/S'
  validExitCodes = @(0)
}

Install-ChocolateyPackage @packageArgs
