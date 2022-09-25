$ErrorActionPreference = 'Stop';

$packageArgs = @{
  packageName    = 'wesnoth'
  fileType       = 'exe'
  url            = 'https://sourceforge.net/projects/wesnoth/files/wesnoth/wesnoth-1.17.8/wesnoth-1.17.8-win64.exe/download'
  softwareName   = 'Battle for Wesnoth*'
  checksum       = '2b8c10681ecc667ad411518ea5dcf538b6d0fb2a32efa36dc4421f651123633d'
  checksumType   = 'sha256'
  silentArgs     = '/S'
  validExitCodes = @(0)
}

Install-ChocolateyPackage @packageArgs
