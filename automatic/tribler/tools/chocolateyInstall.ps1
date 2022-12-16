$ErrorActionPreference = 'Stop'

$toolsPath = Split-Path -parent $MyInvocation.MyCommand.Definition

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  url            = 'https://github.com/Tribler/tribler/releases/download/v7.12.1/Tribler_7.12.1_x86.exe'
  url64          = 'https://github.com/Tribler/tribler/releases/download/v7.12.1/Tribler_7.12.1_x64.exe'
  checksum       = '6b86addf1c0f8ae622a9ceb7c00ed786db7caa6cc13f755b59a2280f638d15aa'
  checksumType   = 'sha256'
  checksum64     = '8bcdf517d23024ba63d58c1336fb65c3f412f6a36f44719f6583474f9aec91fc'
  checksumType64 = 'sha256'
  softwareName   = 'Tribler'
  silentArgs     = '/S'
  validExitCodes = @(0, 1223)
}

Install-ChocolateyPackage @packageArgs
