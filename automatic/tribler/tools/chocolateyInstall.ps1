$ErrorActionPreference = 'Stop'

$toolsPath = Split-Path -parent $MyInvocation.MyCommand.Definition

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  url            = 'https://github.com/Tribler/tribler/releases/download/v7.6.1/Tribler_7.6.1_x86.exe'
  url64          = 'https://github.com/Tribler/tribler/releases/download/v7.6.1/Tribler_7.6.1_x64.exe'
  checksum       = 'a919a654cd75ead25f0c13b5027f278b17e381e67cc227b8c943785e20cea184'
  checksumType   = 'sha256'
  checksum64     = 'c27d91a494a80f2d45ab3dd8cc70a341c2ae17de2d3db4ff676648a1f5a0435d'
  checksumType64 = 'sha256'
  softwareName   = 'Tribler'
  silentArgs     = '/S'
  validExitCodes = @(0, 1223)
}

Install-ChocolateyPackage @packageArgs
