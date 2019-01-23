$ErrorActionPreference = 'Stop'

$toolsPath = Split-Path -parent $MyInvocation.MyCommand.Definition

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  url            = 'https://github.com/Tribler/tribler/releases/download/V7.1.5/Tribler_7.1.5_x86.exe'
  url64          = 'https://github.com/Tribler/tribler/releases/download/V7.1.5/Tribler_7.1.5_x64.exe'
  checksum       = 'c54f0262dba49a015fde71a4e114b0aced5850fd82c33347645a0a1afd0062eb'
  checksumType   = 'sha256'
  checksum64     = '01c349f359707e57f68fb380baf567c9e2f5ca121370ed3634e1c8baac603910'
  checksumType64 = 'sha256'
  softwareName   = 'Tribler'
  silentArgs     = '/S'
  validExitCodes = @(0, 1223)
}

Install-ChocolateyPackage @packageArgs
