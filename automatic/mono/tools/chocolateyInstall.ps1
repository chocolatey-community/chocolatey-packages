$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'msi'
  url            = 'https://download.mono-project.com/archive/5.10.0/windows-installer/mono-5.10.0.160-gtksharp-2.12.45-win32-0.msi'
  url64bit       = 'https://download.mono-project.com/archive/5.10.0/windows-installer/mono-5.10.0.160-x64-0.msi'
  softwareName   = 'Mono for Windows*'
  checksum       = 'f4383925bfb902aacc75dd332e94ec9ca675b61c2fa2d190be6b7a61fddbafe5'
  checksumType   = 'sha256'
  checksum64     = '9849214f6fb7c0174d996a47af95d04771877d637bdef0c8f965ac3cd6ff992e'
  checksumType64 = 'sha256'
  silentArgs     = "/qn /norestart /l*v `"$($env:TEMP)\$($env:chocolateyPackageName).$($env:chocolateyPackageVersion).MsiInstall.log`""
  validExitCodes = @(0, 3010, 1641)
}

Install-ChocolateyPackage @packageArgs
