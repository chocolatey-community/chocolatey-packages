$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'msi'
  url            = 'https://download.mono-project.com/archive/5.12.0/windows-installer/mono-5.12.0.226-gtksharp-2.12.45-win32-0.msi'
  url64bit       = 'https://download.mono-project.com/archive/5.12.0/windows-installer/mono-5.12.0.226-x64-0.msi'
  softwareName   = 'Mono for Windows*'
  checksum       = '93fa94148a1198aa2365dee993c682918acd321a1844c9aea4d198b2483a144a'
  checksumType   = 'sha256'
  checksum64     = '833b79327c6c75e9c724b50f8ff07ce9b82110a77496de85795e8fb0fbfad76a'
  checksumType64 = 'sha256'
  silentArgs     = "/qn /norestart /l*v `"$($env:TEMP)\$($env:chocolateyPackageName).$($env:chocolateyPackageVersion).MsiInstall.log`""
  validExitCodes = @(0, 3010, 1641)
}

Install-ChocolateyPackage @packageArgs
