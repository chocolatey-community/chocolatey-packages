$ErrorActionPreference = 'Stop';

$packageArgs = @{
  packageName    = 'wesnoth'
  fileType       = 'exe'
  url            = 'https://sourceforge.net/projects/wesnoth/files/wesnoth/wesnoth-1.15.15/wesnoth-1.15.15-win64.exe/download'
  softwareName   = 'Battle for Wesnoth*'
  checksum       = '4b67fb56804263d8cf814ab2f8bff5b0f1314d686124cf2e10f51efae55820a2'
  checksumType   = 'sha256'
  silentArgs     = '/S'
  validExitCodes = @(0)
}

Install-ChocolateyPackage @packageArgs
