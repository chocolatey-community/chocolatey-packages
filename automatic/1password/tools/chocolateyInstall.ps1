$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  url            = 'https://c.1password.com/dist/1P/win6/1PasswordSetup-7.3.684.BETA.exe'
  softwareName   = '1Password*'
  checksum       = '8d4896a083d60171ba7db3c20f02656f48f1d65b6052598faef025da79cce94e'
  checksumType   = 'sha256'
  silentArgs     = "/VERYSILENT /NORESTART /SUPPRESSMSGBOXES /SP- /LOG=`"$($env:TEMP)\$($env:chocolateyPackageName).$($env:chocolateyPackageVersion).InnoInstall.log`""
  validExitCodes = @(0)
}

Install-ChocolateyPackage @packageArgs
