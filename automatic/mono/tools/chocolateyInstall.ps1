$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'msi'
  url            = 'https://download.mono-project.com/archive/5.12.0/windows-installer/mono-5.12.0.301-gtksharp-2.12.45-win32-0.msi'
  url64bit       = 'https://download.mono-project.com/archive/5.12.0/windows-installer/mono-5.12.0.301-x64-0.msi'
  softwareName   = 'Mono for Windows*'
  checksum       = '0e377b3c94e52022f2af6786e14cc17e828eb22981de10c6e33c6eb79da17fa5'
  checksumType   = 'sha256'
  checksum64     = '2196750fd4293bb3fc05ce6da6be2457991235112ae1941073721c8ab553f776'
  checksumType64 = 'sha256'
  silentArgs     = "/qn /norestart /l*v `"$($env:TEMP)\$($env:chocolateyPackageName).$($env:chocolateyPackageVersion).MsiInstall.log`""
  validExitCodes = @(0, 3010, 1641)
}

Install-ChocolateyPackage @packageArgs
