$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'msi'
  url            = 'https://downloads.1password.com/win/1PasswordSetup-8.10.82.msi'
  softwareName   = '1Password*'
  checksum       = '8e6a49d6d26d01586dfbbb89b2c2b48d51ef535a9dccea573945bb776b3901ab'
  checksumType   = 'sha256'
  silentArgs     = "/qn /norestart /l*v `"$($env:TEMP)\$($env:chocolateyPackageName).$($env:chocolateyPackageVersion).MsiInstall.log`""
  validExitCodes = @(0, 1641, 3010)
}

Install-ChocolateyPackage @packageArgs
