$ErrorActionPreference = 'Stop';

$packageArgs = @{
  packageName    = 'wesnoth'
  fileType       = 'exe'
  url            = 'https://sourceforge.net/projects/wesnoth/files/wesnoth/wesnoth-1.17.25/wesnoth-1.17.25-win64.exe/download'
  softwareName   = 'Battle for Wesnoth*'
  checksum       = '55db5087365e174c43335ab0e3ba4031923e6c6c56c19458804865011becff7f'
  checksumType   = 'sha256'
  silentArgs     = '/S'
  validExitCodes = @(0)
}

Install-ChocolateyPackage @packageArgs
