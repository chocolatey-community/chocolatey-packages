$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  url            = 'https://cache.agilebits.com/dist/1P/win6/1PasswordSetup-6.8.534.exe'
  softwareName   = '1Password*'
  checksum       = 'c4d5ce45941ab9f69392f4b0276b8fb3930306d4cdcb8f0e4afaf47774e57203'
  checksumType   = 'sha256'
  silentArgs     = "/VERYSILENT /NORESTART /SUPPRESSMSGBOXES /SP- /LOG=`"$($env:TEMP)\$($env:chocolateyPackageName).$($env:chocolateyPackageVersion).InnoInstall.log`""
  validExitCodes = @(0)
}

Install-ChocolateyPackage @packageArgs
