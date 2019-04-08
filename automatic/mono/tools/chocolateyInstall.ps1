$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'msi'
  url            = 'https://download.mono-project.com/archive/5.18.1/windows-installer/mono-5.18.1.3-gtksharp-2.12.45-win32-0.msi'
  url64bit       = 'https://download.mono-project.com/archive/5.18.1/windows-installer/mono-5.18.1.3-x64-0.msi'
  softwareName   = 'Mono for Windows*'
  checksum       = 'c2dbda052aa8adfa89e38b99f1eda293b22fbcd8401a047535c5a2710aa5ea8c'
  checksumType   = 'sha256'
  checksum64     = 'ac6ace744864f4232c3d78dda45ad47559fd99fc7719f18e3fe8ce528953874a'
  checksumType64 = 'sha256'
  silentArgs     = "/qn /norestart /l*v `"$($env:TEMP)\$($env:chocolateyPackageName).$($env:chocolateyPackageVersion).MsiInstall.log`""
  validExitCodes = @(0, 3010, 1641)
}

Install-ChocolateyPackage @packageArgs
