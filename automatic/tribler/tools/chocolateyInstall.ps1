$ErrorActionPreference = 'Stop'

$toolsPath = Split-Path -parent $MyInvocation.MyCommand.Definition

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  url            = 'https://github.com/Tribler/tribler/releases/download/v7.7.1/Tribler_7.7.1_x86.exe'
  url64          = 'https://github.com/Tribler/tribler/releases/download/v7.7.1/Tribler_7.7.1_x64.exe'
  checksum       = 'f4f9e8ae465b327761d7e286e0d699301fb807329d128e6d6095a70649a15deb'
  checksumType   = 'sha256'
  checksum64     = '65784c7a615ad50f85fe79a78c1dd7918512d5fc7dd03c357e69d70a998db7cd'
  checksumType64 = 'sha256'
  softwareName   = 'Tribler'
  silentArgs     = '/S'
  validExitCodes = @(0, 1223)
}

Install-ChocolateyPackage @packageArgs
