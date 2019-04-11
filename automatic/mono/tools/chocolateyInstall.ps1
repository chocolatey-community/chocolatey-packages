$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'msi'
  url            = 'https://download.mono-project.com/archive/5.20.1/windows-installer/mono-5.20.1.19-gtksharp-2.12.45-win32-0.msi'
  url64bit       = 'https://download.mono-project.com/archive/5.20.1/windows-installer/mono-5.20.1.19-x64-0.msi'
  softwareName   = 'Mono for Windows*'
  checksum       = '50b964763edaae697a65ef27848c74e9eaa172050ddca94e5ebcf29ad4117b70'
  checksumType   = 'sha256'
  checksum64     = 'f84dde8ac4cb7de9c063fa0deb4c0fe0f7fecc6d01fda9824ddaada823acf70b'
  checksumType64 = 'sha256'
  silentArgs     = "/qn /norestart /l*v `"$($env:TEMP)\$($env:chocolateyPackageName).$($env:chocolateyPackageVersion).MsiInstall.log`""
  validExitCodes = @(0, 3010, 1641)
}

Install-ChocolateyPackage @packageArgs
