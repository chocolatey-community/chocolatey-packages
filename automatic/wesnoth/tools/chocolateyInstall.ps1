$ErrorActionPreference = 'Stop';

$packageArgs = @{
  packageName    = 'wesnoth'
  fileType       = 'exe'
  url            = 'https://sourceforge.net/projects/wesnoth/files/wesnoth-1.14/wesnoth-1.14.9/wesnoth-1.14.9-win32.exe/download'
  softwareName   = 'Battle for Wesnoth*'
  checksum       = '17fd07ac2a48c9b8abc56d12f503557f007b306eb77a447a1c22d9a3e66371f9'
  checksumType   = 'sha256'
  silentArgs     = '/S'
  validExitCodes = @(0)
}

Install-ChocolateyPackage @packageArgs
