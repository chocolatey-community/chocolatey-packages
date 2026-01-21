$ErrorActionPreference = 'Stop'

$toolsPath = Split-Path -parent $MyInvocation.MyCommand.Definition

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  url64          = 'https://github.com/Tribler/tribler/releases/download/v8.3.1/Tribler_8.3.1_x64.exe'
  checksum64     = '6f3479c51f4286e33243a00c68816cfd122937cd6d0a3b2754d8f8383e6907aa'
  checksumType64 = 'sha256'
  softwareName   = 'Tribler'
  silentArgs     = '/S'
  validExitCodes = @(0, 1223)
}

Install-ChocolateyPackage @packageArgs
