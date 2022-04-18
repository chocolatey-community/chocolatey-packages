$ErrorActionPreference = 'Stop';

$packageArgs = @{
  packageName    = 'wesnoth'
  fileType       = 'exe'
  url            = 'https://sourceforge.net/projects/wesnoth/files/wesnoth/wesnoth-1.17.3/wesnoth-1.17.3-win64.exe/download'
  softwareName   = 'Battle for Wesnoth*'
  checksum       = 'a742eab6e65d700c3c1acc12ffa98dd1c9f11560bdbd947aac911690e60f8188'
  checksumType   = 'sha256'
  silentArgs     = '/S'
  validExitCodes = @(0)
}

Install-ChocolateyPackage @packageArgs
