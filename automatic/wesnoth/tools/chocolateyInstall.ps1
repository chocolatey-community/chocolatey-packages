$ErrorActionPreference = 'Stop';

$packageArgs = @{
  packageName    = 'wesnoth'
  fileType       = 'exe'
  url            = 'https://sourceforge.net/projects/wesnoth/files/wesnoth/wesnoth-1.15.12/wesnoth-1.15.12-win64.exe/download'
  softwareName   = 'Battle for Wesnoth*'
  checksum       = '396dcaf5e6aad22bd1080bb353b389bb12ee133ffa8dd7f1a97903ef3acfefc3'
  checksumType   = 'sha256'
  silentArgs     = '/S'
  validExitCodes = @(0)
}

Install-ChocolateyPackage @packageArgs
