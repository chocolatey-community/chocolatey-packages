$ErrorActionPreference = 'Stop';

$packageArgs = @{
  packageName    = 'wesnoth'
  fileType       = 'exe'
  url            = 'https://sourceforge.net/projects/wesnoth/files/wesnoth/wesnoth-1.19.24/wesnoth-1.19.24-win64.exe/download'
  softwareName   = 'Battle for Wesnoth*'
  checksum       = '8ec391e8e8e285567fec2535737bd3e5f6e4222f7769734c67ae821e12a2f63b'
  checksumType   = 'sha256'
  silentArgs     = '/S'
  validExitCodes = @(0)
}

Install-ChocolateyPackage @packageArgs
