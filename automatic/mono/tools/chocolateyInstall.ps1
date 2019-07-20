$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'msi'
  url            = 'https://download.mono-project.com/archive/6.0.0/windows-installer/mono-6.0.0.313-gtksharp-2.12.45-win32-0.msi'
  url64bit       = 'https://download.mono-project.com/archive/6.0.0/windows-installer/mono-6.0.0.313-x64-0.msi'
  softwareName   = 'Mono for Windows*'
  checksum       = '60928894533dfc8824792933b83e9c1f95572f978f5a801a1861cfb853f689c2'
  checksumType   = 'sha256'
  checksum64     = 'c515eef973a8238b57c17b0971ddfd25df900d1e41cb1f3a7d80c78c339955c1'
  checksumType64 = 'sha256'
  silentArgs     = "/qn /norestart /l*v `"$($env:TEMP)\$($env:chocolateyPackageName).$($env:chocolateyPackageVersion).MsiInstall.log`""
  validExitCodes = @(0, 3010, 1641)
}

Install-ChocolateyPackage @packageArgs
