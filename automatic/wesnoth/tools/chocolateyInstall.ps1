$ErrorActionPreference = 'Stop';

$packageArgs = @{
  packageName    = 'wesnoth'
  fileType       = 'exe'
  url            = 'https://sourceforge.net/projects/wesnoth/files/wesnoth-1.14/wesnoth-1.14.3/wesnoth-1.14.3-win32.exe/download'
  softwareName   = 'Battle for Wesnoth*'
  checksum       = '81799aa26e349e55c330cc6dc95096cf0e4573c07e4215c8bbad999a66f8665b'
  checksumType   = 'sha256'
  silentArgs     = '/S'
  validExitCodes = @(0)
}

Install-ChocolateyPackage @packageArgs
