$ErrorActionPreference = 'Stop';

$packageArgs = @{
  packageName    = 'wesnoth'
  fileType       = 'exe'
  url            = 'https://sourceforge.net/projects/wesnoth/files/wesnoth-1.14/wesnoth-1.14.14/wesnoth-1.14.14-win32.exe/download'
  softwareName   = 'Battle for Wesnoth*'
  checksum       = '454a0a9f6c82da18cd30fe8c7fd8a1f6e9a2f3cb1f53cba5e3c4e7f7c9fd088b'
  checksumType   = 'sha256'
  silentArgs     = '/S'
  validExitCodes = @(0)
}

Install-ChocolateyPackage @packageArgs
