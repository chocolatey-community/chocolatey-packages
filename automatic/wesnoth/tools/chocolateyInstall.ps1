$ErrorActionPreference = 'Stop';

$packageArgs = @{
  packageName    = 'wesnoth'
  fileType       = 'exe'
  url            = 'https://sourceforge.net/projects/wesnoth/files/wesnoth/wesnoth-1.19.28/wesnoth-1.19.28-win64.exe/download'
  softwareName   = 'Battle for Wesnoth*'
  checksum       = '08cef9c130721887a1888b32563d93c0ac22fdfb9353cbd789ecf666b09494eb'
  checksumType   = 'sha256'
  silentArgs     = '/S'
  validExitCodes = @(0)
}

Install-ChocolateyPackage @packageArgs
