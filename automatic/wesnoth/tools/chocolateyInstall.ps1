$ErrorActionPreference = 'Stop';

$packageArgs = @{
  packageName    = 'wesnoth'
  fileType       = 'exe'
  url            = 'https://sourceforge.net/projects/wesnoth/files/wesnoth/wesnoth-1.19.3/wesnoth-1.19.3-win64.exe/download'
  softwareName   = 'Battle for Wesnoth*'
  checksum       = '40a9490b3635c1436697c5100bd388ca7230575c9b4091a1078d4a6d1c558087'
  checksumType   = 'sha256'
  silentArgs     = '/S'
  validExitCodes = @(0)
}

Install-ChocolateyPackage @packageArgs
