$ErrorActionPreference = 'Stop';

$packageArgs = @{
  packageName    = 'wesnoth'
  fileType       = 'exe'
  url            = 'https://sourceforge.net/projects/wesnoth/files/wesnoth/wesnoth-1.17.23/wesnoth-1.17.23-win64.exe/download'
  softwareName   = 'Battle for Wesnoth*'
  checksum       = '99ecbfbf2a35f45fc6606ae5c349b30c60ea46799d9695808490fb1536f7f02f'
  checksumType   = 'sha256'
  silentArgs     = '/S'
  validExitCodes = @(0)
}

Install-ChocolateyPackage @packageArgs
