$ErrorActionPreference = 'Stop';

$packageArgs = @{
  packageName    = 'wesnoth'
  fileType       = 'exe'
  url            = 'https://sourceforge.net/projects/wesnoth/files/wesnoth/wesnoth-1.17.16/wesnoth-1.17.16-win64.exe/download'
  softwareName   = 'Battle for Wesnoth*'
  checksum       = 'bb32908541243bddf72c3ca2623ea7eaa77b307d315485ec5bd7ae653bc3ea01'
  checksumType   = 'sha256'
  silentArgs     = '/S'
  validExitCodes = @(0)
}

Install-ChocolateyPackage @packageArgs
