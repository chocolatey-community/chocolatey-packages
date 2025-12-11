$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'msi'
  url            = 'https://downloads.1password.com/win/1PasswordSetup-8.11.23.msi'
  softwareName   = '1Password*'
  checksum       = '44f7007047ccf0e029d6bd4e4cb1463e0741254c419e77f39c117ce6b20b2abc'
  checksumType   = 'sha256'
  silentArgs     = "/qn /norestart /l*v `"$($env:TEMP)\$($env:chocolateyPackageName).$($env:chocolateyPackageVersion).MsiInstall.log`""
  validExitCodes = @(0, 1641, 3010)
}

Install-ChocolateyPackage @packageArgs
