$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'msi'
  url            = 'https://download.mono-project.com/archive/6.0.0/windows-installer/mono-6.0.0.327-gtksharp-2.12.45-win32-0.msi'
  url64bit       = 'https://download.mono-project.com/archive/6.0.0/windows-installer/mono-6.0.0.327-x64-0.msi'
  softwareName   = 'Mono for Windows*'
  checksum       = '9d104203aff4bc93e6a9bf9dbe241b2a11fe5b4b33a5550d613b06f8384cbe9c'
  checksumType   = 'sha256'
  checksum64     = '0e9dc8749fed842ecb8316713159242220b78586505a610a6cb972563eb90149'
  checksumType64 = 'sha256'
  silentArgs     = "/qn /norestart /l*v `"$($env:TEMP)\$($env:chocolateyPackageName).$($env:chocolateyPackageVersion).MsiInstall.log`""
  validExitCodes = @(0, 3010, 1641)
}

Install-ChocolateyPackage @packageArgs
