$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'msi'
  url            = 'https://download.mono-project.com/archive/5.18.0/windows-installer/mono-5.18.0.268-gtksharp-2.12.45-win32-0.msi'
  url64bit       = 'https://download.mono-project.com/archive/5.18.0/windows-installer/mono-5.18.0.268-x64-0.msi'
  softwareName   = 'Mono for Windows*'
  checksum       = '6a5cff82cc46c0bea69537086e3597cfd1a7c800ead9550c61d9b955360c26aa'
  checksumType   = 'sha256'
  checksum64     = '909785c631c9b866ae8b2d3799e8687d38a48a880d463b3a0e2aa89aeadea10e'
  checksumType64 = 'sha256'
  silentArgs     = "/qn /norestart /l*v `"$($env:TEMP)\$($env:chocolateyPackageName).$($env:chocolateyPackageVersion).MsiInstall.log`""
  validExitCodes = @(0, 3010, 1641)
}

Install-ChocolateyPackage @packageArgs
