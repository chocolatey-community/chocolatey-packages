$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'msi'
  url            = 'https://download.mono-project.com/archive/6.12.0/windows-installer/mono-6.12.0.107-gtksharp-2.12.45-win32-0.msi'
  url64bit       = 'https://download.mono-project.com/archive/6.12.0/windows-installer/mono-6.12.0.107-x64-0.msi'
  softwareName   = 'Mono for Windows*'
  checksum       = '5e1640dc5ba03621331e789e170fd52f09d293e9244311a30f1f1a3ff4752fb3'
  checksumType   = 'sha256'
  checksum64     = '19a7d899e76f0ea33dcfb02cd1efafe0c8592239ad6d03900b3016e6d2ba36ab'
  checksumType64 = 'sha256'
  silentArgs     = "/qn /norestart /l*v `"$($env:TEMP)\$($env:chocolateyPackageName).$($env:chocolateyPackageVersion).MsiInstall.log`""
  validExitCodes = @(0, 3010, 1641)
}

Install-ChocolateyPackage @packageArgs
