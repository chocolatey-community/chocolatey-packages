$ErrorActionPreference = 'Stop';

$packageArgs = @{
  packageName    = 'wesnoth'
  fileType       = 'exe'
  url            = 'https://sourceforge.net/projects/wesnoth/files/wesnoth/wesnoth-1.19.2/wesnoth-1.19.2-win64.exe/download'
  softwareName   = 'Battle for Wesnoth*'
  checksum       = '8897acd811856a4f985a64d67f70ab4dbc1fab9b1e4176b98598c3a39f8b66d6'
  checksumType   = 'sha256'
  silentArgs     = '/S'
  validExitCodes = @(0)
}

Install-ChocolateyPackage @packageArgs
