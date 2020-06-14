$ErrorActionPreference = 'Stop';

$packageArgs = @{
  packageName    = 'wesnoth'
  fileType       = 'exe'
  url            = 'https://sourceforge.net/projects/wesnoth/files/wesnoth-1.14/wesnoth-1.14.13/wesnoth-1.14.13-win32.exe/download'
  softwareName   = 'Battle for Wesnoth*'
  checksum       = '4da71137c3479a9d8f24b7b7d1f7bde10c0657ffc9b7fe45cba87c2ed80a5f7a'
  checksumType   = 'sha256'
  silentArgs     = '/S'
  validExitCodes = @(0)
}

Install-ChocolateyPackage @packageArgs
