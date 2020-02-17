$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'msi'
  url            = 'https://download.mono-project.com/archive/6.8.0/windows-installer/mono-6.8.0.105-gtksharp-2.12.45-win32-0.msi'
  url64bit       = 'https://download.mono-project.com/archive/6.8.0/windows-installer/mono-6.8.0.105-x64-0.msi'
  softwareName   = 'Mono for Windows*'
  checksum       = '2e9431255d103bd63124fa43bd3a1b0f5a73f1dafb3e2fce5c102b2329b0be39'
  checksumType   = 'sha256'
  checksum64     = 'dcbe043636f44623e397e43c8a552789cc747959bfcfbc202556cb6f32b47f1c'
  checksumType64 = 'sha256'
  silentArgs     = "/qn /norestart /l*v `"$($env:TEMP)\$($env:chocolateyPackageName).$($env:chocolateyPackageVersion).MsiInstall.log`""
  validExitCodes = @(0, 3010, 1641)
}

Install-ChocolateyPackage @packageArgs
