$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'msi'
  url            = 'https://download.mono-project.com/archive/6.8.0/windows-installer/mono-6.8.0.123-gtksharp-2.12.45-win32-0.msi'
  url64bit       = 'https://download.mono-project.com/archive/6.8.0/windows-installer/mono-6.8.0.123-x64-0.msi'
  softwareName   = 'Mono for Windows*'
  checksum       = '8d545125d22bf695ba1491cef517bdec9394b409d88aaf1a7d42a9da2363a4ac'
  checksumType   = 'sha256'
  checksum64     = '81755fe866f2cdb8f697d35a70aecb17ea04694e20b4b2463ea617f2e1eac61d'
  checksumType64 = 'sha256'
  silentArgs     = "/qn /norestart /l*v `"$($env:TEMP)\$($env:chocolateyPackageName).$($env:chocolateyPackageVersion).MsiInstall.log`""
  validExitCodes = @(0, 3010, 1641)
}

Install-ChocolateyPackage @packageArgs
