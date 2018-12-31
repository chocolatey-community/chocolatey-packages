$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'msi'
  url            = 'https://download.mono-project.com/archive/5.18.0/windows-installer/mono-5.18.0.225-gtksharp-2.12.45-win32-0.msi'
  url64bit       = 'https://download.mono-project.com/archive/5.18.0/windows-installer/mono-5.18.0.225-x64-0.msi'
  softwareName   = 'Mono for Windows*'
  checksum       = 'e0dcb04fa4bc2f5538b6307eb2afae5e599ed38a5e2d78b537e6eb8d9572d3c0'
  checksumType   = 'sha256'
  checksum64     = '8918670cf4c824e9c86b5e34802c4bbeaa299f6f7382530671854c10d1367f71'
  checksumType64 = 'sha256'
  silentArgs     = "/qn /norestart /l*v `"$($env:TEMP)\$($env:chocolateyPackageName).$($env:chocolateyPackageVersion).MsiInstall.log`""
  validExitCodes = @(0, 3010, 1641)
}

Install-ChocolateyPackage @packageArgs
