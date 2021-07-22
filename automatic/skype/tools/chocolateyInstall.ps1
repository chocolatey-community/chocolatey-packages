$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  softwareName   = 'Skype*'
  url            = 'https://download.skype.com/s4l/download/win/Skype-8.74.0.152.exe'
  checksum       = 'b0080b004786a243df241bae700960c7db54750613bdc4461d79a55e008b2dc6'
  checksumType   = 'sha256'
  silentArgs     = "/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP- /LOG=`"$($env:TEMP)\$($env:chocolateyPackageName).$($env:chocolateyPackageVersion).InnoInstall.log`""
  validExitCodes = @(0)
}

Install-ChocolateyPackage @packageArgs
