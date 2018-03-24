$ErrorActionPreference = 'Stop';

$packageArgs = @{
  packageName    = 'wesnoth'
  fileType       = 'exe'
  url            = 'https://sourceforge.net/projects/wesnoth/files/wesnoth/wesnoth-1.13.12/wesnoth-1.13.12-win32.exe/download'
  softwareName   = 'Battle for Wesnoth*'
  checksum       = '716a7e816bc17df29be0a3d043441dd3a37c8da56e4acdb856040bbf445e6bc3'
  checksumType   = 'sha256'
  silentArgs     = '/S'
  validExitCodes = @(0)
}

Install-ChocolateyPackage @packageArgs
