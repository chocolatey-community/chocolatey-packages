$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'msi'
  url            = 'https://download.mono-project.com/archive/6.12.0/windows-installer/mono-6.12.0.182-gtksharp-2.12.45-win32-0.msi'
  url64bit       = 'https://download.mono-project.com/archive/6.12.0/windows-installer/mono-6.12.0.182-x64-0.msi'
  softwareName   = 'Mono for Windows*'
  checksum       = 'c930c8b96b6cb38d4cf56118ed03c93ba1055ac57f97555f55282474ba4e7796'
  checksumType   = 'sha256'
  checksum64     = '1e6b87d72416cee3d9df2f9a643a09002a3adb5a0b38604adff988446927d5c8'
  checksumType64 = 'sha256'
  silentArgs     = "/qn /norestart /l*v `"$($env:TEMP)\$($env:chocolateyPackageName).$($env:chocolateyPackageVersion).MsiInstall.log`""
  validExitCodes = @(0, 3010, 1641)
}

Install-ChocolateyPackage @packageArgs
