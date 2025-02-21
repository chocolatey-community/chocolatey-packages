$ErrorActionPreference = 'Stop';

$packageArgs = @{
  packageName    = 'wesnoth'
  fileType       = 'exe'
  url            = 'https://sourceforge.net/projects/wesnoth/files/wesnoth-1.18/wesnoth-1.18.4/wesnoth-1.18.4-win64.exe/download'
  softwareName   = 'Battle for Wesnoth*'
  checksum       = 'd7211ba46831bcc456a33cdb66d6c05cf55866eb3314c0880b72b1c8df324ac2'
  checksumType   = 'sha256'
  silentArgs     = '/S'
  validExitCodes = @(0)
}

Install-ChocolateyPackage @packageArgs
