$ErrorActionPreference = 'Stop';

$packageArgs = @{
  packageName    = 'wesnoth'
  fileType       = 'exe'
  url            = 'https://sourceforge.net/projects/wesnoth/files/wesnoth/wesnoth-1.19.10/wesnoth-1.19.10-win64.exe/download'
  softwareName   = 'Battle for Wesnoth*'
  checksum       = '8ad9b6e55102d058ba54b3f45020b9b37ee401a0f6c6aa5df442e478a5b809c9'
  checksumType   = 'sha256'
  silentArgs     = '/S'
  validExitCodes = @(0)
}

Install-ChocolateyPackage @packageArgs
