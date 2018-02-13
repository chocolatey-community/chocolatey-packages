$ErrorActionPreference = 'Stop';

$packageArgs = @{
  packageName    = 'wesnoth'
  fileType       = 'exe'
  url            = 'https://sourceforge.net/projects/wesnoth/files/wesnoth/wesnoth-1.13.10/wesnoth-1.13.10-win32.exe/download'
  softwareName   = 'Battle for Wesnoth*'
  checksum       = 'd32e80fc824a023bd35946687ab6f613820b1451264a7ba6c091130144968036'
  checksumType   = 'sha256'
  silentArgs     = '/S'
  validExitCodes = @(0)
}

Install-ChocolateyPackage @packageArgs
