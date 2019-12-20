$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'msi'
  url            = 'https://download.mono-project.com/archive/6.6.0/windows-installer/mono-6.6.0.161-gtksharp-2.12.45-win32-0.msi'
  url64bit       = 'https://download.mono-project.com/archive/6.6.0/windows-installer/mono-6.6.0.161-x64-0.msi'
  softwareName   = 'Mono for Windows*'
  checksum       = 'e33e52c0946e6f848976886d95be55b1f811aa2b491ff19a6f18dae94c133fa1'
  checksumType   = 'sha256'
  checksum64     = '8d3392ed19977c0b869aaf594fd9c12114d8bcb6185bca27d8329ff5f974d23e'
  checksumType64 = 'sha256'
  silentArgs     = "/qn /norestart /l*v `"$($env:TEMP)\$($env:chocolateyPackageName).$($env:chocolateyPackageVersion).MsiInstall.log`""
  validExitCodes = @(0, 3010, 1641)
}

Install-ChocolateyPackage @packageArgs
