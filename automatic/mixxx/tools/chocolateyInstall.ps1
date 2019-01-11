$ErrorActionPreference = 'Stop'

$toolsPath = Split-Path $MyInvocation.MyCommand.Definition

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  url            = ''
  url64bit       = ''

  softwareName   = 'Mixxx *'

  checksum       = ''
  checksumType   = ''
  checksum64     = ''
  checksumType64 = ''

  silentArgs     = '/quiet'
  validExitCodes = @(0)
}
Install-ChocolateyPackage @packageArgs