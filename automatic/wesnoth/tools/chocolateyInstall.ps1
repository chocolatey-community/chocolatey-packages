$ErrorActionPreference = 'Stop';

$packageArgs = @{
  packageName    = 'wesnoth'
  fileType       = 'exe'
  url            = 'https://sourceforge.net/projects/wesnoth/files/wesnoth/wesnoth-1.17.1/wesnoth-1.17.1-win64.exe/download'
  softwareName   = 'Battle for Wesnoth*'
  checksum       = '0791532d16385e8529f45711573000f56f1fed7e54ef0c6da6a8d186dd1921c9'
  checksumType   = 'sha256'
  silentArgs     = '/S'
  validExitCodes = @(0)
}

Install-ChocolateyPackage @packageArgs
