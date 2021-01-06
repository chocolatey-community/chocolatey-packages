$ErrorActionPreference = 'Stop'

$toolsPath = Split-Path -parent $MyInvocation.MyCommand.Definition

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  url            = 'https://github.com/Tribler/tribler/releases/download/v7.7.0/Tribler_7.7.0_x86.exe'
  url64          = 'https://github.com/Tribler/tribler/releases/download/v7.7.0/Tribler_7.7.0_x64.exe'
  checksum       = '40e3f1996473449e91f9dd018a3868cdf83a37be6fcb269fa4d6cd1e52029d20'
  checksumType   = 'sha256'
  checksum64     = 'fc3050e92099879b677ca96c01b479d6eacb351770dfc069822edca94ad3b704'
  checksumType64 = 'sha256'
  softwareName   = 'Tribler'
  silentArgs     = '/S'
  validExitCodes = @(0, 1223)
}

Install-ChocolateyPackage @packageArgs
