$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  softwareName   = 'Skype*'
  url            = 'https://download.skype.com/s4l/download/win/Skype-8.58.0.93.exe'
  checksum       = 'bd6261f1eabe5e3efb4df5cde749e9f8300a5a2aef515a35e7669da2df7cdb2b'
  checksumType   = 'sha256'
  silentArgs     = "/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP- /LOG=`"$($env:TEMP)\$($env:chocolateyPackageName).$($env:chocolateyPackageVersion).InnoInstall.log`""
  validExitCodes = @(0)
}

Install-ChocolateyPackage @packageArgs
