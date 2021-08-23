$ErrorActionPreference = 'Stop';

$packageArgs = @{
  packageName    = 'wesnoth'
  fileType       = 'exe'
  url            = 'https://sourceforge.net/projects/wesnoth/files/wesnoth/wesnoth-1.15.16/wesnoth-1.15.16-win64.exe/download'
  softwareName   = 'Battle for Wesnoth*'
  checksum       = '1566096c0a955545a41a0e81f89a3f754c7656709478f771489484265b1394b4'
  checksumType   = 'sha256'
  silentArgs     = '/S'
  validExitCodes = @(0)
}

Install-ChocolateyPackage @packageArgs
