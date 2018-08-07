$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'msi'
  url            = 'https://download.mono-project.com/archive/5.14.0/windows-installer/mono-5.14.0.177-gtksharp-2.12.45-win32-0.msi'
  url64bit       = 'https://download.mono-project.com/archive/5.14.0/windows-installer/mono-5.14.0.177-x64-0.msi'
  softwareName   = 'Mono for Windows*'
  checksum       = 'e43be777405b9831d292b6867eb9d72d488b698989ec7c6fba86a1fd87808135'
  checksumType   = 'sha256'
  checksum64     = '0491f76d5909a012076ca0a417ea71431e845908ca4f2fa3414636fe0537e126'
  checksumType64 = 'sha256'
  silentArgs     = "/qn /norestart /l*v `"$($env:TEMP)\$($env:chocolateyPackageName).$($env:chocolateyPackageVersion).MsiInstall.log`""
  validExitCodes = @(0, 3010, 1641)
}

Install-ChocolateyPackage @packageArgs
