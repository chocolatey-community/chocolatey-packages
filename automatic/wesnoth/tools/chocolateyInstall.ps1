$ErrorActionPreference = 'Stop';

$packageArgs = @{
  packageName    = 'wesnoth'
  fileType       = 'exe'
  url            = 'https://sourceforge.net/projects/wesnoth/files/wesnoth/wesnoth-1.15.3/wesnoth-1.15.3-win64.exe/download'
  softwareName   = 'Battle for Wesnoth*'
  checksum       = 'ebf97b5296a62019bc9a5c571e92572c0ac593f314363e1d044e68756ca55ce7'
  checksumType   = 'sha256'
  silentArgs     = '/S'
  validExitCodes = @(0)
}

Install-ChocolateyPackage @packageArgs
