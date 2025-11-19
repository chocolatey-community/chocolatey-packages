$ErrorActionPreference = 'Stop';

$packageArgs = @{
  packageName    = 'wesnoth'
  fileType       = 'exe'
  url            = 'https://sourceforge.net/projects/wesnoth/files/wesnoth/wesnoth-1.19.18/wesnoth-1.19.18-win64.exe/download'
  softwareName   = 'Battle for Wesnoth*'
  checksum       = '3bea895b5ac6520af3c7217283afcc7e17eb96924c3859e559fd04adb35f6fe8'
  checksumType   = 'sha256'
  silentArgs     = '/S'
  validExitCodes = @(0)
}

Install-ChocolateyPackage @packageArgs
