$ErrorActionPreference = 'Stop'
$toolsPath = (Split-Path -Parent $MyInvocation.MyCommand.Definition)
. "$toolsPath\helpers.ps1"

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  url            = 'https://get.geo.opera.com/pub/opera/desktop/51.0.2830.26/win/Opera_51.0.2830.26_Setup.exe'
  url64          = 'https://get.geo.opera.com/pub/opera/desktop/51.0.2830.26/win/Opera_51.0.2830.26_Setup_x64.exe'
  checksum       = 'cc111e0e370da871a8b4ef8cf7d8b6fa5e861e6c1cd06c0109dee16d67c6b80f'
  checksum64     = '19bae79f04688e34563031b2e11b888b1e22c7242e2b104309b6b7fcc6e9d7e4'
  checksumType   = 'sha256'
  checksumType64 = 'sha256'
  silentArgs     = '/install /silent /launchopera 0 /setdefaultbrowser 0'
  validExitCodes = @(0)
}

$version = '51.0.2830.26'
if (!$Env:ChocolateyForce -and (IsVersionAlreadyInstalled $version)) {
  Write-Output "Opera $version is already installed. Skipping download and installation."
} else {
  Install-ChocolateyPackage @packageArgs
}
