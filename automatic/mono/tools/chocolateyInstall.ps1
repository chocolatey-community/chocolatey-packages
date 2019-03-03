$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'msi'
  url            = 'https://download.mono-project.com/archive/5.18.0/windows-installer/mono-5.18.0.240-gtksharp-2.12.45-win32-0.msi'
  url64bit       = 'https://download.mono-project.com/archive/5.18.0/windows-installer/mono-5.18.0.240-x64-0.msi'
  softwareName   = 'Mono for Windows*'
  checksum       = '9b556968c7f57ed0df9a2319ae47ff4dae98e0ba95a3f0e51d8160f918300aee'
  checksumType   = 'sha256'
  checksum64     = 'fee062087528702da74e07efbf5ddb786127650dd56b1367675dd980bf81e05c'
  checksumType64 = 'sha256'
  silentArgs     = "/qn /norestart /l*v `"$($env:TEMP)\$($env:chocolateyPackageName).$($env:chocolateyPackageVersion).MsiInstall.log`""
  validExitCodes = @(0, 3010, 1641)
}

Install-ChocolateyPackage @packageArgs
