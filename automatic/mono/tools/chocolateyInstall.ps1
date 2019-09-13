$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'msi'
  url            = 'https://download.mono-project.com/archive/6.0.0/windows-installer/mono-6.0.0.334-gtksharp-2.12.45-win32-0.msi'
  url64bit       = 'https://download.mono-project.com/archive/6.0.0/windows-installer/mono-6.0.0.334-x64-0.msi'
  softwareName   = 'Mono for Windows*'
  checksum       = 'c6d910d864c37d65d372d668fe059e6774857bfd9e065927b0a4c7a177594537'
  checksumType   = 'sha256'
  checksum64     = 'adc8df0ee8087733e8a745e2b96e2eef09bf8d27be45ed75c5654c11ca898f11'
  checksumType64 = 'sha256'
  silentArgs     = "/qn /norestart /l*v `"$($env:TEMP)\$($env:chocolateyPackageName).$($env:chocolateyPackageVersion).MsiInstall.log`""
  validExitCodes = @(0, 3010, 1641)
}

Install-ChocolateyPackage @packageArgs
