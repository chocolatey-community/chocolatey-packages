$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  softwareName   = 'Skype*'
  fileType       = 'msi'
  url            = 'https://download.skype.com/s4l/download/win/Skype-8.110.0.215.msi'
  checksum       = '36304d9d7c616f189bab16f95588104d56f55e45d8af0f6f78b14b26f2e2921b'
  checksumType   = 'sha256'
  silentArgs     = "/quiet /norestart /l*v `"$($env:TEMP)\$($packageName).$($env:chocolateyPackageVersion).MsiInstall.log`""
  validExitCodes = @(0)
}

Install-ChocolateyPackage @packageArgs
