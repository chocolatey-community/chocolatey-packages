$ErrorActionPreference = 'Stop';

$packageArgs = @{
  packageName    = 'wesnoth'
  fileType       = 'exe'
  url            = 'https://sourceforge.net/projects/wesnoth/files/wesnoth-1.14/wesnoth-1.14.16/wesnoth-1.14.16-win32.exe/download'
  softwareName   = 'Battle for Wesnoth*'
  checksum       = '2334c632d59bbb32e1d12b33c2423bf24e20da3e0d956d5a20e6064e0ac67067'
  checksumType   = 'sha256'
  silentArgs     = '/S'
  validExitCodes = @(0)
}

Install-ChocolateyPackage @packageArgs
