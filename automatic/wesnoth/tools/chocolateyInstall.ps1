$ErrorActionPreference = 'Stop';

$packageArgs = @{
  packageName    = 'wesnoth'
  fileType       = 'exe'
  url            = 'https://sourceforge.net/projects/wesnoth/files/wesnoth/wesnoth-1.15.7/wesnoth-1.15.7-win64.exe/download'
  softwareName   = 'Battle for Wesnoth*'
  checksum       = '921bd8cd2b1b4ef56aef9d8b03a10c09a74eda3caaa39a4a1c851c02e3b93c2f'
  checksumType   = 'sha256'
  silentArgs     = '/S'
  validExitCodes = @(0)
}

Install-ChocolateyPackage @packageArgs
