$ErrorActionPreference = 'Stop'

$toolsPath = Split-Path -parent $MyInvocation.MyCommand.Definition

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  url64          = 'https://github.com/Tribler/tribler/releases/download/v8.2.3/Tribler_8.2.3_x64.exe'
  checksum64     = 'd10ded3f3b55d2e87c01722f84f7c33b531078075758da25b1de4dd35dfcd3fd'
  checksumType64 = 'sha256'
  softwareName   = 'Tribler'
  silentArgs     = '/S'
  validExitCodes = @(0, 1223)
}

Install-ChocolateyPackage @packageArgs
