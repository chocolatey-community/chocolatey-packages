$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  softwareName   = 'Skype*'
  fileType       = 'msi'
  url            = 'https://download.skype.com/s4l/download/win/Skype-8.131.0.202.msi'
  checksum       = 'f17966d4da7e637e4aabfeedde0d88b1ae90236a2cb5b7e2d546a00f3506c6ed'
  checksumType   = 'sha256'
  silentArgs     = "/quiet /norestart /l*v `"$($env:TEMP)\$($packageName).$($env:chocolateyPackageVersion).MsiInstall.log`""
  validExitCodes = @(0)
}

Install-ChocolateyPackage @packageArgs
