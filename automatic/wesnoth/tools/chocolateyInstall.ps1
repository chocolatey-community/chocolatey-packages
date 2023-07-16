$ErrorActionPreference = 'Stop';

$packageArgs = @{
  packageName    = 'wesnoth'
  fileType       = 'exe'
  url            = 'https://sourceforge.net/projects/wesnoth/files/wesnoth/wesnoth-1.17.19/wesnoth-1.17.19-win64.exe/download'
  softwareName   = 'Battle for Wesnoth*'
  checksum       = 'ee2063e1924c02959c7af2df26fe38d60cbde3de34ed6fedc1f1e0c493b1c526'
  checksumType   = 'sha256'
  silentArgs     = '/S'
  validExitCodes = @(0)
}

Install-ChocolateyPackage @packageArgs
