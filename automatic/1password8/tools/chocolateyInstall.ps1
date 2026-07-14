$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'msi'
  url            = 'https://downloads.1password.com/win/1PasswordSetup-8.12.28.msi'
  softwareName   = '1Password*'
  checksum       = 'c7fd4808fba19af902584551b0aac92b9cf16542ede546fbe42d65e286abde90'
  checksumType   = 'sha256'
  silentArgs     = "/qn /norestart /l*v `"$($env:TEMP)\$($env:chocolateyPackageName).$($env:chocolateyPackageVersion).MsiInstall.log`""
  validExitCodes = @(0, 1641, 3010)
}

Install-ChocolateyPackage @packageArgs
