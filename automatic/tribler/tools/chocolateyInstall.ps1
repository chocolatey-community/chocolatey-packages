$ErrorActionPreference = 'Stop'

$toolsPath = Split-Path -parent $MyInvocation.MyCommand.Definition

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  url            = 'https://github.com/Tribler/tribler/releases/download/v7.4.3/Tribler_7.4.3_x86.exe'
  url64          = 'https://github.com/Tribler/tribler/releases/download/v7.4.3/Tribler_7.4.3_x64.exe'
  checksum       = 'b460f4b2973d7fffd4bd82cfa215c8e7babbd2fdff5db2fca6892ba173ba4511'
  checksumType   = 'sha256'
  checksum64     = 'ea629a3aaf772f802d6137da5844ae52782a8d5a1865f0ca652b70291a094d3b'
  checksumType64 = 'sha256'
  softwareName   = 'Tribler'
  silentArgs     = '/S'
  validExitCodes = @(0, 1223)
}

Install-ChocolateyPackage @packageArgs
