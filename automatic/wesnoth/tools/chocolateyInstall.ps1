$ErrorActionPreference = 'Stop';

$packageArgs = @{
  packageName    = 'wesnoth'
  fileType       = 'exe'
  url            = 'https://sourceforge.net/projects/wesnoth/files/wesnoth/wesnoth-1.15.0/wesnoth-1.15.0-win32.exe/download'
  softwareName   = 'Battle for Wesnoth*'
  checksum       = '17b8c1a1cea8742bca17b734c15d81b454d95a8a9e8cc72979316eb4e5c5d957'
  checksumType   = 'sha256'
  silentArgs     = '/S'
  validExitCodes = @(0)
}

Install-ChocolateyPackage @packageArgs
