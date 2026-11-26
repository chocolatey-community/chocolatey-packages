$ErrorActionPreference = 'Stop';

$packageArgs = @{
  packageName    = 'wesnoth'
  fileType       = 'exe'
  url            = 'https://sourceforge.net/projects/wesnoth/files/wesnoth/wesnoth-1.19.30/wesnoth-1.19.30-win64.exe/download'
  softwareName   = 'Battle for Wesnoth*'
  checksum       = 'ffdaa458ecd64c2a5a813a6bbc4df72ba02a6df6e160616a7c934c25026bff31'
  checksumType   = 'sha256'
  silentArgs     = '/S'
  validExitCodes = @(0)
}

Install-ChocolateyPackage @packageArgs
