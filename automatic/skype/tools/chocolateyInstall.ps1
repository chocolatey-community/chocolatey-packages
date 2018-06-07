$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  softwareName   = 'Skype*'
  url            = 'https://endpoint920510.azureedge.net/s4l/s4l/download/win/Skype-8.23.0.10.exe'
  checksum       = '316f74c4193c68aa0979a5761c7dd43af9945fe2baa3e11b8261de0e8f5ba0f7'
  checksumType   = 'sha256'
  silentArgs     = "/SILENT /SUPPRESSMSGBOXES /NORESTART /SP- /LOG=`"$($env:TEMP)\$($env:chocolateyPackageName).$($env:chocolateyPackageVersion).InnoInstall.log`""
  validExitCodes = @(0)
}

Install-ChocolateyPackage @packageArgs
