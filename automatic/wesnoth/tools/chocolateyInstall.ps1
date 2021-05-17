$ErrorActionPreference = 'Stop';

$packageArgs = @{
  packageName    = 'wesnoth'
  fileType       = 'exe'
  url            = 'https://sourceforge.net/projects/wesnoth/files/wesnoth/wesnoth-1.15.13/wesnoth-1.15.13-win64.exe/download'
  softwareName   = 'Battle for Wesnoth*'
  checksum       = '88ee76f34af32f6ce5511b0f2b324879f02b9fc55749fd2addaeda068c204fb6'
  checksumType   = 'sha256'
  silentArgs     = '/S'
  validExitCodes = @(0)
}

Install-ChocolateyPackage @packageArgs
