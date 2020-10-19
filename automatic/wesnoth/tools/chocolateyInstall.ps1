$ErrorActionPreference = 'Stop';

$packageArgs = @{
  packageName    = 'wesnoth'
  fileType       = 'exe'
  url            = 'https://sourceforge.net/projects/wesnoth/files/wesnoth/wesnoth-1.15.6/wesnoth-1.15.6-win64.exe/download'
  softwareName   = 'Battle for Wesnoth*'
  checksum       = 'e96b8abd723572aac6d06140ed0b14d7f1b936537aad37d552212c7c46b72cf3'
  checksumType   = 'sha256'
  silentArgs     = '/S'
  validExitCodes = @(0)
}

Install-ChocolateyPackage @packageArgs
