$ErrorActionPreference = 'Stop';

$packageArgs = @{
  packageName    = 'wesnoth'
  fileType       = 'exe'
  url            = 'https://sourceforge.net/projects/wesnoth/files/wesnoth-1.18/wesnoth-1.18.3/wesnoth-1.18.3-win64.exe/download'
  softwareName   = 'Battle for Wesnoth*'
  checksum       = '6df3ac68fb662e013a3800e09723391bdc432bbee173aacb8f501c4c36babd4c'
  checksumType   = 'sha256'
  silentArgs     = '/S'
  validExitCodes = @(0)
}

Install-ChocolateyPackage @packageArgs
