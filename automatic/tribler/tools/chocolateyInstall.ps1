$ErrorActionPreference = 'Stop'

$toolsPath = Split-Path -parent $MyInvocation.MyCommand.Definition

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  url64          = 'https://github.com/Tribler/tribler/releases/download/v8.1.3/Tribler_8.1.3_x64.exe'
  checksum64     = '84a62b57db703702ccdb4499a202c6faeb2ac9df643b868e74b6470e5f54f0d6'
  checksumType64 = 'sha256'
  softwareName   = 'Tribler'
  silentArgs     = '/S'
  validExitCodes = @(0, 1223)
}

Install-ChocolateyPackage @packageArgs
