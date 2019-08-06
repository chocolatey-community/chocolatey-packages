$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'msi'
  url            = 'https://download.mono-project.com/archive/6.0.0/windows-installer/mono-6.0.0.319-gtksharp-2.12.45-win32-0.msi'
  url64bit       = 'https://download.mono-project.com/archive/6.0.0/windows-installer/mono-6.0.0.319-x64-0.msi'
  softwareName   = 'Mono for Windows*'
  checksum       = '24839c8b1772576ec4d28b90993125b35f26eb61819587be8ae35b2478477104'
  checksumType   = 'sha256'
  checksum64     = '29c495ee2b52c65e79d3a38670dcc66f155f1d1b8fe1cd19a7b357921863aade'
  checksumType64 = 'sha256'
  silentArgs     = "/qn /norestart /l*v `"$($env:TEMP)\$($env:chocolateyPackageName).$($env:chocolateyPackageVersion).MsiInstall.log`""
  validExitCodes = @(0, 3010, 1641)
}

Install-ChocolateyPackage @packageArgs
