$ErrorActionPreference = 'Stop'

$toolsPath = Split-Path -parent $MyInvocation.MyCommand.Definition

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  url            = 'https://github.com/Tribler/tribler/releases/download/v7.5.4/Tribler_7.5.4_x86.exe'
  url64          = 'https://github.com/Tribler/tribler/releases/download/v7.5.4/Tribler_7.5.4_x64.exe'
  checksum       = 'e25eba452b54adabd6831213107c90af0c2dbc3f61bc6a952643c06b8643f257'
  checksumType   = 'sha256'
  checksum64     = '9ead0509dc2a2984203c93287146be49cf53430446dbe4a676f8aa08ecdc67be'
  checksumType64 = 'sha256'
  softwareName   = 'Tribler'
  silentArgs     = '/S'
  validExitCodes = @(0, 1223)
}

Install-ChocolateyPackage @packageArgs
