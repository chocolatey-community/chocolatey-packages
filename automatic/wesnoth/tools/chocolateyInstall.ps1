$ErrorActionPreference = 'Stop';

$packageArgs = @{
  packageName    = 'wesnoth'
  fileType       = 'exe'
  url            = 'https://sourceforge.net/projects/wesnoth/files/wesnoth/wesnoth-1.19.8/wesnoth-1.19.8-win64.exe/download'
  softwareName   = 'Battle for Wesnoth*'
  checksum       = 'e97c6cf15419c625af4be0a8867c082614e586bf026b41fbc681f98ef73f13c9'
  checksumType   = 'sha256'
  silentArgs     = '/S'
  validExitCodes = @(0)
}

Install-ChocolateyPackage @packageArgs
