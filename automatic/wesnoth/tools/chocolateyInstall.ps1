$ErrorActionPreference = 'Stop';

$packageArgs = @{
  packageName    = 'wesnoth'
  fileType       = 'exe'
  url            = 'https://sourceforge.net/projects/wesnoth/files/wesnoth-1.14/wesnoth-1.14.12/wesnoth-1.14.12-win32.exe/download'
  softwareName   = 'Battle for Wesnoth*'
  checksum       = '5b52436467a105f9fc52d2f7ce2294ef4a1b2360cf3e60dc5f4811b307157d99'
  checksumType   = 'sha256'
  silentArgs     = '/S'
  validExitCodes = @(0)
}

Install-ChocolateyPackage @packageArgs
