$ErrorActionPreference = 'Stop'

$toolsPath = Split-Path -parent $MyInvocation.MyCommand.Definition

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  url            = 'https://github.com/Tribler/tribler/releases/download/v7.13.3/Tribler_7.13.3_x86.exe'
  url64          = 'https://github.com/Tribler/tribler/releases/download/v7.13.3/Tribler_7.13.3_x64.exe'
  checksum       = 'dc5051e397ee969fa30496213f577725b7b688e2872d6889653825cee38e53b2'
  checksumType   = 'sha256'
  checksum64     = '169c0981485bc121629a7d20466c17bf49ea66261eb9e269a4bebdfb143cee03'
  checksumType64 = 'sha256'
  softwareName   = 'Tribler'
  silentArgs     = '/S'
  validExitCodes = @(0, 1223)
}

Install-ChocolateyPackage @packageArgs
