$ErrorActionPreference = 'Stop';

$packageArgs = @{
  packageName    = 'wesnoth'
  fileType       = 'exe'
  url            = 'https://sourceforge.net/projects/wesnoth/files/wesnoth/wesnoth-1.17.24/wesnoth-1.17.24-win64.exe/download'
  softwareName   = 'Battle for Wesnoth*'
  checksum       = '0ea5b39a57493d543e721f425bc8f4d7846af601a4501c6750a8727cc863e352'
  checksumType   = 'sha256'
  silentArgs     = '/S'
  validExitCodes = @(0)
}

Install-ChocolateyPackage @packageArgs
