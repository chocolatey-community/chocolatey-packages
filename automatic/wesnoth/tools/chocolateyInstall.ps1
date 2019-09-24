$ErrorActionPreference = 'Stop';

$packageArgs = @{
  packageName    = 'wesnoth'
  fileType       = 'exe'
  url            = 'https://sourceforge.net/projects/wesnoth/files/wesnoth/wesnoth-1.15.1/wesnoth-1.15.1-win32.exe/download'
  softwareName   = 'Battle for Wesnoth*'
  checksum       = 'b201177a6501c125e173c473f3061054849f79151b46808a3e6cabd41515ad7b'
  checksumType   = 'sha256'
  silentArgs     = '/S'
  validExitCodes = @(0)
}

Install-ChocolateyPackage @packageArgs
