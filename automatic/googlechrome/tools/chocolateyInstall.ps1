$toolsPath = Split-Path $MyInvocation.MyCommand.Definition
. $toolsPath\helpers.ps1

$version = '78.0.3904.87'
if ($version -eq (Get-ChromeVersion)) {
  Write-Host "Google Chrome $version is already installed."
  return
}

$packageArgs = @{
  packageName            = 'googlechrome'
  fileType               = 'MSI'
  url                    = 'https://dl.google.com/tag/s/dl/chrome/install/googlechromestandaloneenterprise.msi'
  url64bit               = 'https://dl.google.com/tag/s/dl/chrome/install/googlechromestandaloneenterprise64.msi'
  checksum               = '1e5983829ec48224e8f8a3fb5e8316fd288efecdab83e419985fdfb69852c876'
  checksum64             = '12603539daefd14d57c4016e85b64fda581de209faa039397c8273fb8feb312f'
  checksumType           = 'sha256'
  checksumType64         = 'sha256'
  silentArgs             = "/quiet /norestart /l*v `"$($env:TEMP)\$($env:chocolateyPackageName).$($env:chocolateyPackageVersion).MsiInstall.log`""
  validExitCodes         = @(0)
}

if (Get-Chrome32bitInstalled) { 'url64bit', 'checksum64', 'checksumType64' | ForEach-Object { $packageArgs.Remove($_) } }
Install-ChocolateyPackage @packageArgs
