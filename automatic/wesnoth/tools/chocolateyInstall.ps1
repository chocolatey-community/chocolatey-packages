$ErrorActionPreference = 'Stop';

$packageArgs = @{
  packageName    = 'wesnoth'
  fileType       = 'exe'
  url            = 'https://sourceforge.net/projects/wesnoth/files/wesnoth/wesnoth-1.15.2/wesnoth-1.15.2-win32.exe/download'
  softwareName   = 'Battle for Wesnoth*'
  checksum       = '8739135b58baab23cfd6c86fa92ef64033aecd96377f646961a9db7ab0318626'
  checksumType   = 'sha256'
  silentArgs     = '/S'
  validExitCodes = @(0)
}

Install-ChocolateyPackage @packageArgs
