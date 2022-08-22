$ErrorActionPreference = 'Stop';

$packageArgs = @{
  packageName    = 'wesnoth'
  fileType       = 'exe'
  url            = 'https://sourceforge.net/projects/wesnoth/files/wesnoth/wesnoth-1.17.7/wesnoth-1.17.7-win64.exe/download'
  softwareName   = 'Battle for Wesnoth*'
  checksum       = '88ba7bdd0920a31bf384aa74cfd52833a38fb44fc2a915c0c7be9fe38f82dc42'
  checksumType   = 'sha256'
  silentArgs     = '/S'
  validExitCodes = @(0)
}

Install-ChocolateyPackage @packageArgs
