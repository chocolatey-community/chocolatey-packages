$ErrorActionPreference = 'Stop';

$packageArgs = @{
  packageName    = 'wesnoth'
  fileType       = 'exe'
  url            = 'https://sourceforge.net/projects/wesnoth/files/wesnoth-1.12/wesnoth-1.12/wesnoth-1.12-win32.exe/download'
  softwareName   = 'Battle for Wesnoth*'
  checksum       = 'e9b804eb6b1075b3104d13e679ff5e145ee82afd2352154641245263c04a39dc'
  checksumType   = 'sha256'
  silentArgs     = '/S'
  validExitCodes = @(0)
}

Install-ChocolateyPackage @packageArgs
