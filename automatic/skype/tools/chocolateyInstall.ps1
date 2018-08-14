$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  softwareName   = 'Skype*'
  url            = 'https://endpoint920510.azureedge.net/s4l/s4l/download/win/Skype-8.28.0.41.exe'
  checksum       = '29e65e1f11f634ece6ab1dcc5a5c8edc3a93514b5a189bbf76e63222859dc142'
  checksumType   = 'sha256'
  silentArgs     = "/SILENT /SUPPRESSMSGBOXES /NORESTART /SP- /LOG=`"$($env:TEMP)\$($env:chocolateyPackageName).$($env:chocolateyPackageVersion).InnoInstall.log`""
  validExitCodes = @(0)
}

Install-ChocolateyPackage @packageArgs
