$ErrorActionPreference = 'Stop';

$packageArgs = @{
  packageName    = 'wesnoth'
  fileType       = 'exe'
  url            = 'https://sourceforge.net/projects/wesnoth/files/wesnoth/wesnoth-1.19.14/wesnoth-1.19.14-win64.exe/download'
  softwareName   = 'Battle for Wesnoth*'
  checksum       = 'f4505fd37abc85f2f965169d871625cfc05a419ccaaf5e5290226134a4aab57a'
  checksumType   = 'sha256'
  silentArgs     = '/S'
  validExitCodes = @(0)
}

Install-ChocolateyPackage @packageArgs
