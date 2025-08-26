$ErrorActionPreference = 'Stop';

$packageArgs = @{
  packageName    = 'wesnoth'
  fileType       = 'exe'
  url            = 'https://sourceforge.net/projects/wesnoth/files/wesnoth/wesnoth-1.19.15/wesnoth-1.19.15-win64.exe/download'
  softwareName   = 'Battle for Wesnoth*'
  checksum       = 'a17bd1fcdc7bebbf4b83cca838e1882bece27d7f092646b88661a0d47b5dcd5e'
  checksumType   = 'sha256'
  silentArgs     = '/S'
  validExitCodes = @(0)
}

Install-ChocolateyPackage @packageArgs
