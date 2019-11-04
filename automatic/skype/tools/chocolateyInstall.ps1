$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  softwareName   = 'Skype*'
  url            = 'https://download.skype.com/s4l/download/win/Skype-8.54.0.85.exe'
  checksum       = '2d0190434bbe58b960a49804ec2da4df86b3f38526c6d2fa7fe638dbb17e4ff5'
  checksumType   = 'sha256'
  silentArgs     = "/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP- /LOG=`"$($env:TEMP)\$($env:chocolateyPackageName).$($env:chocolateyPackageVersion).InnoInstall.log`""
  validExitCodes = @(0)
}

Install-ChocolateyPackage @packageArgs
