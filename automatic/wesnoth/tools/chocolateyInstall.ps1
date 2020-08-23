$ErrorActionPreference = 'Stop';

$packageArgs = @{
  packageName    = 'wesnoth'
  fileType       = 'exe'
  url            = 'https://sourceforge.net/projects/wesnoth/files/wesnoth/wesnoth-1.15.4/wesnoth-1.15.4-win64.exe/download'
  softwareName   = 'Battle for Wesnoth*'
  checksum       = '080f2e64d06b1299c650cb11b73c7834a61b0b4702b87801ea1342cf307fb5ef'
  checksumType   = 'sha256'
  silentArgs     = '/S'
  validExitCodes = @(0)
}

Install-ChocolateyPackage @packageArgs
