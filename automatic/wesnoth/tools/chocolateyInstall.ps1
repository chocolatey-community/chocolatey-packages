$ErrorActionPreference = 'Stop';

$packageArgs = @{
  packageName    = 'wesnoth'
  fileType       = 'exe'
  url            = 'https://sourceforge.net/projects/wesnoth/files/wesnoth/wesnoth-1.19.7/wesnoth-1.19.7-win64.exe/download'
  softwareName   = 'Battle for Wesnoth*'
  checksum       = '8601a0869fb470e77f412b952dfa730babf768c9f50fb0386fbbd7be10c38600'
  checksumType   = 'sha256'
  silentArgs     = '/S'
  validExitCodes = @(0)
}

Install-ChocolateyPackage @packageArgs
