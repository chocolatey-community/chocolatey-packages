$ErrorActionPreference = 'Stop';

$packageArgs = @{
  packageName    = 'wesnoth'
  fileType       = 'exe'
  url            = 'https://sourceforge.net/projects/wesnoth/files/wesnoth-1.16/wesnoth-1.16.1/wesnoth-1.16.1-win64.exe/download'
  softwareName   = 'Battle for Wesnoth*'
  checksum       = '9c63f3ffc69832277bb9060e3f7a977cbbbd269c1820fc79bcdb5dc5ac915d66'
  checksumType   = 'sha256'
  silentArgs     = '/S'
  validExitCodes = @(0)
}

Install-ChocolateyPackage @packageArgs
