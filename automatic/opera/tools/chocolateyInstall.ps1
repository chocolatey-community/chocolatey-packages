$ErrorActionPreference = 'Stop'
$toolsPath = (Split-Path -Parent $MyInvocation.MyCommand.Definition)
. "$toolsPath\helpers.ps1"

if (Is32BitInstalled) { $env:ChocolateyForceX86 = $true }

$version     = '45.0.2552.881'
$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  url            = 'https://get.geo.opera.com/pub/opera/desktop/45.0.2552.881/win/Opera_45.0.2552.881_Setup.exe'
  url64          = 'https://get.geo.opera.com/pub/opera/desktop/45.0.2552.881/win/Opera_45.0.2552.881_Setup_x64.exe'
  checksum       = '8e3c6ee7d63e0c7849bea63c37a6bfa5dbf299d6219bbc555e51bdba29f3091d'
  checksum64     = 'cde1a683b1e2f8b1e7d8ad5e2ff55b425cbc451710cfe1dd8a2b25c1a840278c'
  checksumType   = 'sha256'
  checksumType64 = 'sha256'
  silentArgs     = '/install /silent /launchopera 0 /setdefaultbrowser 0'
  validExitCodes = @(0)
}

if (IsVersionAlreadyInstalled $version) {
  Write-Output "Opera $version is already installed. Skipping download and installation."
} else {
  Install-ChocolateyPackage @packageArgs
}
