$ErrorActionPreference = 'Stop';

$packageArgs = @{
  packageName    = 'wesnoth'
  fileType       = 'exe'
  url            = 'https://sourceforge.net/projects/wesnoth/files/wesnoth/wesnoth-1.19.1/wesnoth-1.19.1-win64.exe/download'
  softwareName   = 'Battle for Wesnoth*'
  checksum       = '99f74efe0b57df68b853a8538cd9bf9a1cd045ae893dd5ff00870022126ed135'
  checksumType   = 'sha256'
  silentArgs     = '/S'
  validExitCodes = @(0)
}

Install-ChocolateyPackage @packageArgs
