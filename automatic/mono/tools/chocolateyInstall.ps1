$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'msi'
  url            = 'https://download.mono-project.com/archive/6.12.0/windows-installer/mono-6.12.0.179-gtksharp-2.12.45-win32-0.msi'
  url64bit       = 'https://download.mono-project.com/archive/6.12.0/windows-installer/mono-6.12.0.179-x64-0.msi'
  softwareName   = 'Mono for Windows*'
  checksum       = '8a2d860e88fa40ff104bc4debd79de9206f3f75c37cda336685b7c6df2547f8e'
  checksumType   = 'sha256'
  checksum64     = 'fa8918004d475b721d9acb77d9b197d09af6857e5f24a7449472735f13e98811'
  checksumType64 = 'sha256'
  silentArgs     = "/qn /norestart /l*v `"$($env:TEMP)\$($env:chocolateyPackageName).$($env:chocolateyPackageVersion).MsiInstall.log`""
  validExitCodes = @(0, 3010, 1641)
}

Install-ChocolateyPackage @packageArgs
