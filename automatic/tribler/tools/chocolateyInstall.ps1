$ErrorActionPreference = 'Stop'

$toolsPath = Split-Path -parent $MyInvocation.MyCommand.Definition

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  url            = 'https://github.com/Tribler/tribler/releases/download/v7.6.0/Tribler_7.6.0_x86.exe'
  url64          = 'https://github.com/Tribler/tribler/releases/download/v7.6.0/Tribler_7.6.0_x64.exe'
  checksum       = '824f0d436ea30b1e4d693f1caf3a639e346a7de0064bc19ef9695efc4452845f'
  checksumType   = 'sha256'
  checksum64     = 'bbcb397a7b668d76011f1452a93a65ead1403561242ec5dc94419836fbd34f0c'
  checksumType64 = 'sha256'
  softwareName   = 'Tribler'
  silentArgs     = '/S'
  validExitCodes = @(0, 1223)
}

Install-ChocolateyPackage @packageArgs
