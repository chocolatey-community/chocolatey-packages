$ErrorActionPreference = 'Stop'

$toolsPath = Split-Path $MyInvocation.MyCommand.Definition

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  url            = 'https://downloads.mixxx.org/mixxx-2.2.2/mixxx-2.2.2-win32.exe'
  url64bit       = 'https://downloads.mixxx.org/mixxx-2.2.2/mixxx-2.2.2-win64.exe'

  softwareName   = 'Mixxx *'

  checksum       = 'ba12135dcbabfb3d46364a591b79cd485698168d9f46ae6d49d80ea69d9528df8a093b8f013f1110f0e9cc82fa68afda14b73bf380c3e400e8eb31f4aba66cac'
  checksumType   = 'sha512'
  checksum64     = '10b751c63b9ff7d2e18bad12e00d0e327c0e0d3ade6de957a9e7cff848c7b0cf82402134fdf4865181d8292bd4b927492bf690286bb9955e8e16da9fc15c0655'
  checksumType64 = 'sha512'

  silentArgs     = '/quiet'
  validExitCodes = @(0)
}
Install-ChocolateyPackage @packageArgs
