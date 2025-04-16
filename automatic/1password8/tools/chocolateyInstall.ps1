$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'msi'
  url            = 'https://downloads.1password.com/win/1PasswordSetup-8.10.72.msi'
  softwareName   = '1Password*'
  checksum       = '75ce721f1b81639a4d60fd10ad1b6850ea8ac7d52844ea759c9b3f94871ee2b6'
  checksumType   = 'sha256'
  silentArgs     = "/qn /norestart /l*v `"$($env:TEMP)\$($env:chocolateyPackageName).$($env:chocolateyPackageVersion).MsiInstall.log`""
  validExitCodes = @(0, 1641, 3010)
}

Install-ChocolateyPackage @packageArgs
