$ErrorActionPreference = 'Stop';

$packageArgs = @{
  packageName    = 'wesnoth'
  fileType       = 'exe'
  url            = 'https://sourceforge.net/projects/wesnoth/files/wesnoth/wesnoth-1.19.26/wesnoth-1.19.26-win64.exe/download'
  softwareName   = 'Battle for Wesnoth*'
  checksum       = 'b77289f7a8233ff2af8a4d3d651d6bfd047bb923557e27471f5f18f870e4fd94'
  checksumType   = 'sha256'
  silentArgs     = '/S'
  validExitCodes = @(0)
}

Install-ChocolateyPackage @packageArgs
