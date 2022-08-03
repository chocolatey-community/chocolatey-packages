$ErrorActionPreference = 'Stop';

$packageArgs = @{
  packageName    = 'wesnoth'
  fileType       = 'exe'
  url            = 'https://sourceforge.net/projects/wesnoth/files/wesnoth-1.16/wesnoth-1.16.5/wesnoth-1.16.5-win64.exe/download'
  softwareName   = 'Battle for Wesnoth*'
  checksum       = 'af5bdb70e348807dd56fe71d36e90a3a180274c91e8e7345db74961bb4340862'
  checksumType   = 'sha256'
  silentArgs     = '/S'
  validExitCodes = @(0)
}

Install-ChocolateyPackage @packageArgs
