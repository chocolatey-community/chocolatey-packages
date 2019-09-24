$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'msi'
  url            = 'https://download.mono-project.com/archive/6.4.0/windows-installer/mono-6.4.0.198-gtksharp-2.12.45-win32-0.msi'
  url64bit       = 'https://download.mono-project.com/archive/6.4.0/windows-installer/mono-6.4.0.198-x64-0.msi'
  softwareName   = 'Mono for Windows*'
  checksum       = '8957ca62bed562dc12d1e03baf2691901a73907459f54871789de2943225aaa1'
  checksumType   = 'sha256'
  checksum64     = '4f135b672017ea861539320cdba124768364fd653d7736d3498dc77cc249abe1'
  checksumType64 = 'sha256'
  silentArgs     = "/qn /norestart /l*v `"$($env:TEMP)\$($env:chocolateyPackageName).$($env:chocolateyPackageVersion).MsiInstall.log`""
  validExitCodes = @(0, 3010, 1641)
}

Install-ChocolateyPackage @packageArgs
