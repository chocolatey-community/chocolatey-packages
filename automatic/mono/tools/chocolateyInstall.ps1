$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'msi'
  url            = 'https://download.mono-project.com/archive/5.18.1/windows-installer/mono-5.18.1.0-gtksharp-2.12.45-win32-0.msi'
  url64bit       = 'https://download.mono-project.com/archive/5.18.1/windows-installer/mono-5.18.1.0-x64-0.msi'
  softwareName   = 'Mono for Windows*'
  checksum       = 'e43020f562044bf2aa8f2a972debf661b76659dac7901d8a2c8853e36bad154c'
  checksumType   = 'sha256'
  checksum64     = 'e35cb806fd030693972ea23a69c62405b767cd185d6229cf30be627222201fa9'
  checksumType64 = 'sha256'
  silentArgs     = "/qn /norestart /l*v `"$($env:TEMP)\$($env:chocolateyPackageName).$($env:chocolateyPackageVersion).MsiInstall.log`""
  validExitCodes = @(0, 3010, 1641)
}

Install-ChocolateyPackage @packageArgs
