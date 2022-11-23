$ErrorActionPreference = 'Stop';

$packageArgs = @{
  packageName    = 'wesnoth'
  fileType       = 'exe'
  url            = 'https://sourceforge.net/projects/wesnoth/files/wesnoth/wesnoth-1.17.10/wesnoth-1.17.10-win64.exe/download'
  softwareName   = 'Battle for Wesnoth*'
  checksum       = '41fa886dd3eee58c1ae1dffce9ad54ec5dc63536db29db7151663debbbb98185'
  checksumType   = 'sha256'
  silentArgs     = '/S'
  validExitCodes = @(0)
}

Install-ChocolateyPackage @packageArgs
