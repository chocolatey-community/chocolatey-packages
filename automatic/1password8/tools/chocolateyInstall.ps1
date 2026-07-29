$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'msi'
  url            = 'https://downloads.1password.com/win/1PasswordSetup-8.12.30.msi'
  softwareName   = '1Password*'
  checksum       = '65bbda1a2efea756625be2b1698b6f3b73e14830f20ec142dc98d33c73ffcbfa'
  checksumType   = 'sha256'
  silentArgs     = "/qn /norestart /l*v `"$($env:TEMP)\$($env:chocolateyPackageName).$($env:chocolateyPackageVersion).MsiInstall.log`""
  validExitCodes = @(0, 1641, 3010)
}

Install-ChocolateyPackage @packageArgs
