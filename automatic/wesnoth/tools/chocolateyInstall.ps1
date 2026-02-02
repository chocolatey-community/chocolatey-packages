$ErrorActionPreference = 'Stop';

$packageArgs = @{
  packageName    = 'wesnoth'
  fileType       = 'exe'
  url            = 'https://sourceforge.net/projects/wesnoth/files/wesnoth/wesnoth-1.19.20/wesnoth-1.19.20-win64.exe/download'
  softwareName   = 'Battle for Wesnoth*'
  checksum       = 'c55a71350f5aab18074a5cc781bc66a56a29086624df85f4e155d5a1a4e966f9'
  checksumType   = 'sha256'
  silentArgs     = '/S'
  validExitCodes = @(0)
}

Install-ChocolateyPackage @packageArgs
