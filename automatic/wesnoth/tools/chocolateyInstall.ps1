$ErrorActionPreference = 'Stop';

$packageArgs = @{
  packageName    = 'wesnoth'
  fileType       = 'exe'
  url            = 'https://sourceforge.net/projects/wesnoth/files/wesnoth-1.18/wesnoth-1.18.6/wesnoth-1.18.6-win64.exe/download'
  softwareName   = 'Battle for Wesnoth*'
  checksum       = '7365efdc70c127f6d0bfbc6a8f976e6cba1eec59f2bbfb6dc27644534670b162'
  checksumType   = 'sha256'
  silentArgs     = '/S'
  validExitCodes = @(0)
}

Install-ChocolateyPackage @packageArgs
