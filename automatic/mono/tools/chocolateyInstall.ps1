$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'msi'
  url            = 'https://download.mono-project.com/archive/6.12.0/windows-installer/mono-6.12.0.206-gtksharp-2.12.45-win32-0.msi'
  url64bit       = 'https://download.mono-project.com/archive/6.12.0/windows-installer/mono-6.12.0.206-x64-0.msi'
  softwareName   = 'Mono for Windows*'
  checksum       = '3f0e2216f52b6ecf249c3c2b9da4b6520ab46ea5307d63a7dba40cabf7e034c9'
  checksumType   = 'sha256'
  checksum64     = '4125f57d97cfa88257915edc969e913de198cd8e22396a29849037479a0ac368'
  checksumType64 = 'sha256'
  silentArgs     = "/qn /norestart /l*v `"$($env:TEMP)\$($env:chocolateyPackageName).$($env:chocolateyPackageVersion).MsiInstall.log`""
  validExitCodes = @(0, 3010, 1641)
}

Install-ChocolateyPackage @packageArgs
