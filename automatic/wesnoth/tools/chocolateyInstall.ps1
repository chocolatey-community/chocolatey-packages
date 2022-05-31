$ErrorActionPreference = 'Stop';

$packageArgs = @{
  packageName    = 'wesnoth'
  fileType       = 'exe'
  url            = 'https://sourceforge.net/projects/wesnoth/files/wesnoth-1.16/wesnoth-1.16.3/wesnoth-1.16.3-win64.exe/download'
  softwareName   = 'Battle for Wesnoth*'
  checksum       = '6c7ce087640aba804cb9720e1553eb4e8dd91a2a9938d42eeae21b5668423efa'
  checksumType   = 'sha256'
  silentArgs     = '/S'
  validExitCodes = @(0)
}

Install-ChocolateyPackage @packageArgs
