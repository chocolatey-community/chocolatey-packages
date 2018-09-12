$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  softwareName   = 'Skype*'
  url            = 'https://endpoint920510.azureedge.net/s4l/s4l/download/win/Skype-8.30.0.50.exe'
  checksum       = '5b769d80f0916e7e82a422481062b9e558449cf3542983883e4622d5e49618f8'
  checksumType   = 'sha256'
  silentArgs     = "/SILENT /SUPPRESSMSGBOXES /NORESTART /SP- /LOG=`"$($env:TEMP)\$($env:chocolateyPackageName).$($env:chocolateyPackageVersion).InnoInstall.log`""
  validExitCodes = @(0)
}

Install-ChocolateyPackage @packageArgs
