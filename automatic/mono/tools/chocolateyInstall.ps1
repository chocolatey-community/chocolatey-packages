$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'msi'
  url            = 'https://download.mono-project.com/archive/6.8.0/windows-installer/mono-6.8.0.96-gtksharp-2.12.45-win32-0.msi'
  url64bit       = 'https://download.mono-project.com/archive/6.8.0/windows-installer/mono-6.8.0.96-x64-0.msi'
  softwareName   = 'Mono for Windows*'
  checksum       = 'cc793c3a9c6b4302885fd8ade7f71521075934b29f99ecf4cef7af9f2d9e9704'
  checksumType   = 'sha256'
  checksum64     = '2d1671de6656d5fc83baf19022f4c9392e54f74628538d6a3788ea729a70bf6d'
  checksumType64 = 'sha256'
  silentArgs     = "/qn /norestart /l*v `"$($env:TEMP)\$($env:chocolateyPackageName).$($env:chocolateyPackageVersion).MsiInstall.log`""
  validExitCodes = @(0, 3010, 1641)
}

Install-ChocolateyPackage @packageArgs
