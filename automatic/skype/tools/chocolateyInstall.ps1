$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  softwareName   = 'Skype*'
  fileType       = 'msi'
  url            = 'https://download.skype.com/s4l/download/win/Skype-8.106.0.212.msi'
  checksum       = 'b024ef810c357dfb7a80993d3fd437f992a0efd0911ca891a0b8b20a3d9cb28d'
  checksumType   = 'sha256'
  silentArgs     = "/quiet /norestart /l*v `"$($env:TEMP)\$($packageName).$($env:chocolateyPackageVersion).MsiInstall.log`""
  validExitCodes = @(0)
}

Install-ChocolateyPackage @packageArgs
