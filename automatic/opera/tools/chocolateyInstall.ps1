$ErrorActionPreference = 'Stop'
$toolsPath = (Split-Path -Parent $MyInvocation.MyCommand.Definition)
. "$toolsPath\helpers.ps1"

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  url            = 'https://get.geo.opera.com/pub/opera/desktop/51.0.2830.40/win/Opera_51.0.2830.40_Setup.exe'
  url64          = 'https://get.geo.opera.com/pub/opera/desktop/51.0.2830.40/win/Opera_51.0.2830.40_Setup_x64.exe'
  checksum       = 'e1e51cc66f9dbfb2efce962d18bc4f837ccc143367ecc051d529e372d47df39f'
  checksum64     = 'c06d01924aa87806ff9c796fdde19111e3bb39158b9c4fafb47e6d3e2ef0bc16'
  checksumType   = 'sha256'
  checksumType64 = 'sha256'
  silentArgs     = '/install /silent /launchopera 0 /setdefaultbrowser 0'
  validExitCodes = @(0)
}

$version = '51.0.2830.40'
if (!$Env:ChocolateyForce -and (IsVersionAlreadyInstalled $version)) {
  Write-Output "Opera $version is already installed. Skipping download and installation."
} else {
  Install-ChocolateyPackage @packageArgs
}
