$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'msi'
  url            = 'https://download.mono-project.com/archive/6.10.0/windows-installer/mono-6.10.0.104-gtksharp-2.12.45-win32-0.msi'
  url64bit       = 'https://download.mono-project.com/archive/6.10.0/windows-installer/mono-6.10.0.104-x64-0.msi'
  softwareName   = 'Mono for Windows*'
  checksum       = '8c681dbe0490da1a412c2d8674c16522927ee204707c34494c5538b4032465d5'
  checksumType   = 'sha256'
  checksum64     = '8c52108ac8cff1bd045601bdfbc3e93419b8a53f123c5cf4d2e597b7416b2fbf'
  checksumType64 = 'sha256'
  silentArgs     = "/qn /norestart /l*v `"$($env:TEMP)\$($env:chocolateyPackageName).$($env:chocolateyPackageVersion).MsiInstall.log`""
  validExitCodes = @(0, 3010, 1641)
}

Install-ChocolateyPackage @packageArgs
