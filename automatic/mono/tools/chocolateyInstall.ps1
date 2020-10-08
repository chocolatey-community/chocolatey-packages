$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'msi'
  url            = 'https://download.mono-project.com/archive/6.12.0/windows-installer/mono-6.12.0.98-gtksharp-2.12.45-win32-0.msi'
  url64bit       = 'https://download.mono-project.com/archive/6.12.0/windows-installer/mono-6.12.0.98-x64-0.msi'
  softwareName   = 'Mono for Windows*'
  checksum       = '01fb215a26f462d39c7add813289f1d371834ed2e2aea2148aff57e4d2ec23a0'
  checksumType   = 'sha256'
  checksum64     = '37d1d9b4a5d0590ead7b9c1f9f72b9b795271aa3fa3b409679222731ce83f849'
  checksumType64 = 'sha256'
  silentArgs     = "/qn /norestart /l*v `"$($env:TEMP)\$($env:chocolateyPackageName).$($env:chocolateyPackageVersion).MsiInstall.log`""
  validExitCodes = @(0, 3010, 1641)
}

Install-ChocolateyPackage @packageArgs
