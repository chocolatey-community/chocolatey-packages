$ErrorActionPreference = 'Stop';

$packageArgs = @{
  packageName    = 'wesnoth'
  fileType       = 'exe'
  url            = 'https://sourceforge.net/projects/wesnoth/files/wesnoth/wesnoth-1.19.13/wesnoth-1.19.13-win64.exe/download'
  softwareName   = 'Battle for Wesnoth*'
  checksum       = '7a096d9b0171b59b1fa6d400b0537ea11b5ffc6702dc821f09b9250486fba30a'
  checksumType   = 'sha256'
  silentArgs     = '/S'
  validExitCodes = @(0)
}

Install-ChocolateyPackage @packageArgs
