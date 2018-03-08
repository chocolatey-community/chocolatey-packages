$ErrorActionPreference = 'Stop'
$toolsPath = (Split-Path -Parent $MyInvocation.MyCommand.Definition)
. "$toolsPath\helpers.ps1"

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  url            = 'https://get.geo.opera.com/pub/opera/desktop/51.0.2830.55/win/Opera_51.0.2830.55_Setup.exe'
  url64          = 'https://get.geo.opera.com/pub/opera/desktop/51.0.2830.55/win/Opera_51.0.2830.55_Setup_x64.exe'
  checksum       = '2223f921deae93c9b8b19841630c230d54d98a56b9648d55b212a70652d1a5e4'
  checksum64     = 'a3bff2ea5719ec3396431b286894f42638c200adabaa54f8aa31dfef45ae7ac1'
  checksumType   = 'sha256'
  checksumType64 = 'sha256'
  silentArgs     = '/install /silent /launchopera 0 /setdefaultbrowser 0'
  validExitCodes = @(0)
}

$version = '51.0.2830.55'
if (!$Env:ChocolateyForce -and (IsVersionAlreadyInstalled $version)) {
  Write-Output "Opera $version is already installed. Skipping download and installation."
} else {
  Install-ChocolateyPackage @packageArgs
}
