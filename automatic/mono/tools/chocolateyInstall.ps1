$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'msi'
  url            = 'https://download.mono-project.com/archive/5.12.0/windows-installer/mono-5.12.0.223-gtksharp-2.12.45-win32-0.msi'
  url64bit       = 'https://download.mono-project.com/archive/5.12.0/windows-installer/mono-5.12.0.223-x64-0.msi'
  softwareName   = 'Mono for Windows*'
  checksum       = '4607142048905d01d8ca87cd9eb00b8fb9b9ad5e7e5179ab6d50d39bb16b8a4b'
  checksumType   = 'sha256'
  checksum64     = '66463c9871211b5c20aa84d9aaea14dacc5376598d7f342cf3071fc7fea06c6d'
  checksumType64 = 'sha256'
  silentArgs     = "/qn /norestart /l*v `"$($env:TEMP)\$($env:chocolateyPackageName).$($env:chocolateyPackageVersion).MsiInstall.log`""
  validExitCodes = @(0, 3010, 1641)
}

Install-ChocolateyPackage @packageArgs
