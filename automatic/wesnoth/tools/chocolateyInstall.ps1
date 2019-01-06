$ErrorActionPreference = 'Stop';

$packageArgs = @{
  packageName    = 'wesnoth'
  fileType       = 'exe'
  url            = 'https://sourceforge.net/projects/wesnoth/files/wesnoth-1.14/wesnoth-1.14.5/wesnoth-1.14.5-win32.exe/download'
  softwareName   = 'Battle for Wesnoth*'
  checksum       = '8cc97ce344b07179df210ba6139124b53134d11e8ab24efe7121be88db8f5543'
  checksumType   = 'sha256'
  silentArgs     = '/S'
  validExitCodes = @(0)
}

Install-ChocolateyPackage @packageArgs
