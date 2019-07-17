$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'msi'
  url            = 'https://download.mono-project.com/archive/5.20.1/windows-installer/mono-5.20.1.34-gtksharp-2.12.45-win32-0.msi'
  url64bit       = 'https://download.mono-project.com/archive/5.20.1/windows-installer/mono-5.20.1.34-x64-0.msi'
  softwareName   = 'Mono for Windows*'
  checksum       = 'a9b302db6bedca3abeba120f60d71bac1030bbf3925876293cb00ffb0adfa450'
  checksumType   = 'sha256'
  checksum64     = 'c650713990b7bae92aa37629691f373a704fe4a0e0bee10553e6c7eaf1823890'
  checksumType64 = 'sha256'
  silentArgs     = "/qn /norestart /l*v `"$($env:TEMP)\$($env:chocolateyPackageName).$($env:chocolateyPackageVersion).MsiInstall.log`""
  validExitCodes = @(0, 3010, 1641)
}

Install-ChocolateyPackage @packageArgs
