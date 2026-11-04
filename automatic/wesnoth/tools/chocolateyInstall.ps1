$ErrorActionPreference = 'Stop';

$packageArgs = @{
  packageName    = 'wesnoth'
  fileType       = 'exe'
  url            = 'https://sourceforge.net/projects/wesnoth/files/wesnoth/wesnoth-1.19.29/wesnoth-1.19.29-win64.exe/download'
  softwareName   = 'Battle for Wesnoth*'
  checksum       = '844a9262824d244eb4b87495b69bb6f223cad24f144fe1b714cc1bafdf3439ce'
  checksumType   = 'sha256'
  silentArgs     = '/S'
  validExitCodes = @(0)
}

Install-ChocolateyPackage @packageArgs
