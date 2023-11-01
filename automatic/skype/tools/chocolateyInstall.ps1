$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  softwareName   = 'Skype*'
  fileType       = 'msi'
  url            = 'https://download.skype.com/s4l/download/win/Skype-8.107.0.215.msi'
  checksum       = 'b687788e011c4d0a366383f92accb9a30bc89478821e2c2703d2d5169d260668'
  checksumType   = 'sha256'
  silentArgs     = "/quiet /norestart /l*v `"$($env:TEMP)\$($packageName).$($env:chocolateyPackageVersion).MsiInstall.log`""
  validExitCodes = @(0)
}

Install-ChocolateyPackage @packageArgs
