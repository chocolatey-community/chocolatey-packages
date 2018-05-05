$ErrorActionPreference = 'Stop';

$packageArgs = @{
  packageName    = 'wesnoth'
  fileType       = 'exe'
  url            = 'https://sourceforge.net/projects/wesnoth/files/wesnoth-1.14/wesnoth-1.14.0/wesnoth-1.14.0-win32.exe/download'
  softwareName   = 'Battle for Wesnoth*'
  checksum       = '6302681505f3903dc9b52bf81acc13c32f81197c56763594373ca56f2fa624d4'
  checksumType   = 'sha256'
  silentArgs     = '/S'
  validExitCodes = @(0)
}

Install-ChocolateyPackage @packageArgs
