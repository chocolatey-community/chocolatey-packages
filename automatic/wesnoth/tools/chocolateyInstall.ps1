$ErrorActionPreference = 'Stop';

$packageArgs = @{
  packageName    = 'wesnoth'
  fileType       = 'exe'
  url            = 'https://sourceforge.net/projects/wesnoth/files/wesnoth/wesnoth-1.17.21/wesnoth-1.17.21-win64.exe/download'
  softwareName   = 'Battle for Wesnoth*'
  checksum       = '71576bf14d9e38f4ad0d4018d44ae669257374a867c58fd1df6943bb797bbde2'
  checksumType   = 'sha256'
  silentArgs     = '/S'
  validExitCodes = @(0)
}

Install-ChocolateyPackage @packageArgs
