$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'msi'
  url            = 'http://download.mono-project.com/archive/4.4.2/windows-installer/mono-4.4.2.11-gtksharp-2.12.38-win32-0.msi'
  url64bit       = ''
  softwareName   = 'Mono for Windows*'
  checksum       = ''
  checksumType   = ''
  checksum64     = ''
  checksumType64 = ''
  silentArgs     = "/qn /norestart /l*v `"$($env:TEMP)\$($env:chocolateyPackageName).$($env:chocolateyPackageVersion).MsiInstall.log`""
  validExitCodes = @(0, 3010, 1641)
}

Install-ChocolateyPackage @packageArgs
