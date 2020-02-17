$ErrorActionPreference = 'Stop';

$packageArgs = @{
  packageName    = 'wesnoth'
  fileType       = 'exe'
  url            = 'https://sourceforge.net/projects/wesnoth/files/wesnoth-1.14/wesnoth-1.14.11/wesnoth-1.14.11-win32.exe/download'
  softwareName   = 'Battle for Wesnoth*'
  checksum       = '7aa2f11d00b4bc5dd7b24fdcbfb65bc210f3853ec8286ee7756e187691f8622d'
  checksumType   = 'sha256'
  silentArgs     = '/S'
  validExitCodes = @(0)
}

Install-ChocolateyPackage @packageArgs
