$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  url            = 'https://cache.agilebits.com/dist/1P/win6/1PasswordSetup-6.8.496.exe'
  softwareName   = '1Password*'
  checksum       = '1660eee7cd822b47aeb49f656723014c27dbf0c029e0929255f05c33d492a1b7'
  checksumType   = 'sha256'
  silentArgs     = "/VERYSILENT /NORESTART /SUPPRESSMSGBOXES /SP- /LOG=`"$($env:TEMP)\$($env:chocolateyPackageName).$($env:chocolateyPackageVersion).InnoInstall.log`""
  validExitCodes = @(0)
}

Install-ChocolateyPackage @packageArgs
