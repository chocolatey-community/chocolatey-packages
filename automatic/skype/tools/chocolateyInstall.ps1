$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  softwareName   = 'Skype*'
  url            = 'https://endpoint920510.azureedge.net/s4l/s4l/download/win/Skype-8.29.0.47.exe'
  checksum       = '5d932a8f98b0e6de221ce6f3c29c7c552245ec55a51a1c1e11e566b6f7b8a694'
  checksumType   = 'sha256'
  silentArgs     = "/SILENT /SUPPRESSMSGBOXES /NORESTART /SP- /LOG=`"$($env:TEMP)\$($env:chocolateyPackageName).$($env:chocolateyPackageVersion).InnoInstall.log`""
  validExitCodes = @(0)
}

Install-ChocolateyPackage @packageArgs
