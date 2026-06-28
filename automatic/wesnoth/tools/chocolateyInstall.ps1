$ErrorActionPreference = 'Stop';

$packageArgs = @{
  packageName    = 'wesnoth'
  fileType       = 'exe'
  url            = 'https://sourceforge.net/projects/wesnoth/files/wesnoth/wesnoth-1.19.25/wesnoth-1.19.25-win64.exe/download'
  softwareName   = 'Battle for Wesnoth*'
  checksum       = 'b29d0e9bed037f4eb7bbeece49dea6a0cce1bc3c4e53e5c3f4a19d53ee7a2271'
  checksumType   = 'sha256'
  silentArgs     = '/S'
  validExitCodes = @(0)
}

Install-ChocolateyPackage @packageArgs
