$ErrorActionPreference = 'Stop'

$toolsPath = Split-Path $MyInvocation.MyCommand.Definition

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  url            = 'https://downloads.mixxx.org/mixxx-2.2.0/mixxx-2.2.0-win32.exe'
  url64bit       = 'https://downloads.mixxx.org/mixxx-2.2.0/mixxx-2.2.0-win64.exe'

  softwareName   = 'Mixxx *'

  checksum       = 'f8fa5a0562947555d13986a08e222f79ec4b458f51be9cca50d3d4d7c0072aa32407301cc6e12ecf492f77adad937b5f41551397400625d3668d9373b47a0c17'
  checksumType   = 'sha512'
  checksum64     = '6d4bb3707f95095f79958eda6eee576b166c8f630dde512be8d56fcd75a6d4208af2fe199c9f9ba6fb30b129bef15d5b37cc47bdf28157e0d2d0adc0513c3024'
  checksumType64 = 'sha512'

  silentArgs     = '/quiet'
  validExitCodes = @(0)
}
Install-ChocolateyPackage @packageArgs
