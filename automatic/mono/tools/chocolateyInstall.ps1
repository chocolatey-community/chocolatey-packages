$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'msi'
  url            = 'https://download.mono-project.com/archive/5.10.1/windows-installer/mono-5.10.1.47-gtksharp-2.12.45-win32-0.msi'
  url64bit       = 'https://download.mono-project.com/archive/5.10.1/windows-installer/mono-5.10.1.47-x64-0.msi'
  softwareName   = 'Mono for Windows*'
  checksum       = '5e97f7913bd96ee6b8a950ffc7238af2bbc1715e639a9a2114be13f69e36f71e'
  checksumType   = 'sha256'
  checksum64     = '97a6b9f9a7edb3ad1f420d3527d59889077555a4eb43d258264b5bc356001228'
  checksumType64 = 'sha256'
  silentArgs     = "/qn /norestart /l*v `"$($env:TEMP)\$($env:chocolateyPackageName).$($env:chocolateyPackageVersion).MsiInstall.log`""
  validExitCodes = @(0, 3010, 1641)
}

Install-ChocolateyPackage @packageArgs
