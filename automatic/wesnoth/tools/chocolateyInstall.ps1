$ErrorActionPreference = 'Stop';

$packageArgs = @{
  packageName    = 'wesnoth'
  fileType       = 'exe'
  url            = 'https://sourceforge.net/projects/wesnoth/files/wesnoth-1.14/wesnoth-1.14.2/wesnoth-1.14.2-win32.exe/download'
  softwareName   = 'Battle for Wesnoth*'
  checksum       = '1f28dba9daeec6d5473b3c8802a30dd0c840a4fd44afc0993368207978d88ff3'
  checksumType   = 'sha256'
  silentArgs     = '/S'
  validExitCodes = @(0)
}

Install-ChocolateyPackage @packageArgs
