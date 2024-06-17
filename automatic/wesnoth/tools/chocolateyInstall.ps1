$ErrorActionPreference = 'Stop';

$packageArgs = @{
  packageName    = 'wesnoth'
  fileType       = 'exe'
  url            = 'https://sourceforge.net/projects/wesnoth/files/wesnoth-1.18/wesnoth-1.18.1/wesnoth-1.18.1-win64.exe/download'
  softwareName   = 'Battle for Wesnoth*'
  checksum       = '3283296b29a68d43633ac6d42c34816b4f23c8b425d1ccc6bfbad43386bdcea2'
  checksumType   = 'sha256'
  silentArgs     = '/S'
  validExitCodes = @(0)
}

Install-ChocolateyPackage @packageArgs
