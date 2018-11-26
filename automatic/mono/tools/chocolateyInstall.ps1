$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'msi'
  url            = 'https://download.mono-project.com/archive/5.16.0/windows-installer/mono-5.16.0.220-gtksharp-2.12.45-win32-0.msi'
  url64bit       = 'https://download.mono-project.com/archive/5.16.0/windows-installer/mono-5.16.0.220-x64-0.msi'
  softwareName   = 'Mono for Windows*'
  checksum       = '2016c9c658f5c3793ea733fc67210915df124ff32261509df5e0625d0964a21c'
  checksumType   = 'sha256'
  checksum64     = '947ce174494d63dc19252006a0860126fe1edd4bd7587ca971c2479c60931976'
  checksumType64 = 'sha256'
  silentArgs     = "/qn /norestart /l*v `"$($env:TEMP)\$($env:chocolateyPackageName).$($env:chocolateyPackageVersion).MsiInstall.log`""
  validExitCodes = @(0, 3010, 1641)
}

Install-ChocolateyPackage @packageArgs
