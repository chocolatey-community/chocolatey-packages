$ErrorActionPreference = 'Stop';

$packageArgs = @{
  packageName    = 'wesnoth'
  fileType       = 'exe'
  url            = 'https://sourceforge.net/projects/wesnoth/files/wesnoth-1.14/wesnoth-1.14.7/wesnoth-1.14.7-win32.exe/download'
  softwareName   = 'Battle for Wesnoth*'
  checksum       = '31b2acfa65cb383012c04c8adbe903b6c3a6ef6a7a32d02a5c49e2e8fcd8ca26'
  checksumType   = 'sha256'
  silentArgs     = '/S'
  validExitCodes = @(0)
}

Install-ChocolateyPackage @packageArgs
