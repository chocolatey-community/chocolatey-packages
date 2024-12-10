$ErrorActionPreference = 'Stop';

$packageArgs = @{
  packageName    = 'wesnoth'
  fileType       = 'exe'
  url            = 'https://sourceforge.net/projects/wesnoth/files/wesnoth/wesnoth-1.19.6/wesnoth-1.19.6-win64.exe/download'
  softwareName   = 'Battle for Wesnoth*'
  checksum       = 'cdffa5bedab426f37d4aedaab78e8a92e164e128249bef27e7185686a7f0a2d3'
  checksumType   = 'sha256'
  silentArgs     = '/S'
  validExitCodes = @(0)
}

Install-ChocolateyPackage @packageArgs
