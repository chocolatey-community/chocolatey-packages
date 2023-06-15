$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'msi'
  url            = 'https://download.mono-project.com/archive/6.12.0/windows-installer/mono-6.12.0.199-gtksharp-2.12.45-win32-0.msi'
  url64bit       = 'https://download.mono-project.com/archive/6.12.0/windows-installer/mono-6.12.0.199-x64-0.msi'
  softwareName   = 'Mono for Windows*'
  checksum       = '6eceda58480e87c097193969a2e5442ed7fd1134291a03fcfe525705a836a680'
  checksumType   = 'sha256'
  checksum64     = 'd3d103f56238c421a34d3cb17f5377139b1c075521024bb71da4aafefe4fba6d'
  checksumType64 = 'sha256'
  silentArgs     = "/qn /norestart /l*v `"$($env:TEMP)\$($env:chocolateyPackageName).$($env:chocolateyPackageVersion).MsiInstall.log`""
  validExitCodes = @(0, 3010, 1641)
}

Install-ChocolateyPackage @packageArgs
