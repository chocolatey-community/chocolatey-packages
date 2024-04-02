$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  softwareName   = 'Skype*'
  fileType       = 'msi'
  url            = 'https://download.skype.com/s4l/download/win/Skype-8.116.0.213.msi'
  checksum       = '25088a01209d34a61e2ab2ed4ae37d03ccd3c2fc362703c1fa7bb9d88cfc95b0'
  checksumType   = 'sha256'
  silentArgs     = "/quiet /norestart /l*v `"$($env:TEMP)\$($packageName).$($env:chocolateyPackageVersion).MsiInstall.log`""
  validExitCodes = @(0)
}

Install-ChocolateyPackage @packageArgs
