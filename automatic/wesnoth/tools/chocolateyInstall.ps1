$ErrorActionPreference = 'Stop';

$packageArgs = @{
  packageName    = 'wesnoth'
  fileType       = 'exe'
  url            = 'https://sourceforge.net/projects/wesnoth/files/wesnoth-1.16/wesnoth-1.16.2/wesnoth-1.16.2-win64.exe/download'
  softwareName   = 'Battle for Wesnoth*'
  checksum       = 'c890bb91fbf38c26881ad1f2f5ceb3d9cb5b5565da8ccb43fac2bd407ce167b3'
  checksumType   = 'sha256'
  silentArgs     = '/S'
  validExitCodes = @(0)
}

Install-ChocolateyPackage @packageArgs
