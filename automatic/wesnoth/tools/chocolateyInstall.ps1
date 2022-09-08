$ErrorActionPreference = 'Stop';

$packageArgs = @{
  packageName    = 'wesnoth'
  fileType       = 'exe'
  url            = 'https://sourceforge.net/projects/wesnoth/files/wesnoth-1.16/wesnoth-1.16.6/wesnoth-1.16.6-win64.exe/download'
  softwareName   = 'Battle for Wesnoth*'
  checksum       = 'f94f8bee0b5ec1ad75cdd7e0e0f8854f33204df955fec785251457b15bee3c08'
  checksumType   = 'sha256'
  silentArgs     = '/S'
  validExitCodes = @(0)
}

Install-ChocolateyPackage @packageArgs
