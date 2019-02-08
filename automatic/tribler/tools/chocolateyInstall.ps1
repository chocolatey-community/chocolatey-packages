$ErrorActionPreference = 'Stop'

$toolsPath = Split-Path -parent $MyInvocation.MyCommand.Definition

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  url            = 'https://github.com/Tribler/tribler/releases/download/v7.2.2/Tribler_7.2.2_x86.exe'
  url64          = 'https://github.com/Tribler/tribler/releases/download/v7.2.2/Tribler_7.2.2_x64.exe'
  checksum       = '9684de83d64b00b4a386c3dcebbb2324b8f463a7ffbd7afd9ada19bb8858b9e0'
  checksumType   = 'sha256'
  checksum64     = '794ecbae6578e285f73def12c5504faa5411088903b24d9b02faad58f5570456'
  checksumType64 = 'sha256'
  softwareName   = 'Tribler'
  silentArgs     = '/S'
  validExitCodes = @(0, 1223)
}

Install-ChocolateyPackage @packageArgs
