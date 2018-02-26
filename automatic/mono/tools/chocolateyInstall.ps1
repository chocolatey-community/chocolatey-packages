$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'msi'
  url            = 'https://download.mono-project.com/archive/5.10.0/windows-installer/mono-5.10.0.140-gtksharp-2.12.45-win32-0.msi'
  url64bit       = 'https://download.mono-project.com/archive/5.10.0/windows-installer/mono-5.10.0.140-x64-0.msi'
  softwareName   = 'Mono for Windows*'
  checksum       = 'beb3fdb4e28da5a609093b159981a6143c5006aaa3113ba7cf0dbea7b884bebb'
  checksumType   = 'sha256'
  checksum64     = '86f1953c34061c941c49cd445521b06bbc4e7fde1a0027c26f7365b74ead828a'
  checksumType64 = 'sha256'
  silentArgs     = "/qn /norestart /l*v `"$($env:TEMP)\$($env:chocolateyPackageName).$($env:chocolateyPackageVersion).MsiInstall.log`""
  validExitCodes = @(0, 3010, 1641)
}

Install-ChocolateyPackage @packageArgs
