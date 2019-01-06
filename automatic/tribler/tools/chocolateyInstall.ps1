$ErrorActionPreference = 'Stop'

$toolsPath = Split-Path -parent $MyInvocation.MyCommand.Definition

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  url            = 'https://github.com/Tribler/tribler/releases/download/v7.1.3/Tribler_7.1.3_x86.exe'
  url64          = 'https://github.com/Tribler/tribler/releases/download/v7.1.3/Tribler_7.1.3_x64.exe'
  checksum       = 'a37ded547b9f53778015c4da06f6fb50370bc917963dba19c0fb31d5041a4ca9'
  checksumType   = 'sha256'
  checksum64     = '2162d28723f7a30861b2fa26825c0a26b911305aa14bf38bca823a49e25f6c25'
  checksumType64 = 'sha256'
  softwareName   = 'Tribler'
  silentArgs     = '/S'
  validExitCodes = @(0, 1223)
}

Install-ChocolateyPackage @packageArgs
