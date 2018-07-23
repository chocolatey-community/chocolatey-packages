$ErrorActionPreference = 'Stop';

$packageArgs = @{
  packageName    = 'wesnoth'
  fileType       = 'exe'
  url            = 'https://sourceforge.net/projects/wesnoth/files/wesnoth-1.14/wesnoth-1.14.4/wesnoth-1.14.4-win32.exe/download'
  softwareName   = 'Battle for Wesnoth*'
  checksum       = 'fe6c276970efa5d510a31976c58949b034aa3f393ee7ea75ccfbbfdfd4c5cc22'
  checksumType   = 'sha256'
  silentArgs     = '/S'
  validExitCodes = @(0)
}

Install-ChocolateyPackage @packageArgs
