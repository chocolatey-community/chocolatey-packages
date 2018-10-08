$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'msi'
  url            = 'https://download.mono-project.com/archive/5.16.0/windows-installer/mono-5.16.0.179-gtksharp-2.12.45-win32-0.msi'
  url64bit       = 'https://download.mono-project.com/archive/5.16.0/windows-installer/mono-5.16.0.179-x64-0.msi'
  softwareName   = 'Mono for Windows*'
  checksum       = '0b385b66d7d3ec641e5e52151932b66a5dcb4563926e50a74c53346866b36d05'
  checksumType   = 'sha256'
  checksum64     = 'c643d3e55e8d05ffe182ea11bcb05ec7e033d063e123eef285e6c02a68ec2316'
  checksumType64 = 'sha256'
  silentArgs     = "/qn /norestart /l*v `"$($env:TEMP)\$($env:chocolateyPackageName).$($env:chocolateyPackageVersion).MsiInstall.log`""
  validExitCodes = @(0, 3010, 1641)
}

Install-ChocolateyPackage @packageArgs
