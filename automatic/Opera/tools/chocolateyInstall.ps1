$ErrorActionPreference = 'Stop'
$toolsPath = (Split-Path -Parent $MyInvocation.MyCommand.Definition)
. "$toolsPath\helpers.ps1"

if (Is32BitInstalled) { $env:ChocolateyForceX86 = $true }

$version     = '44.0.2510.1449'
$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  url            = 'https://get.geo.opera.com/pub/opera/desktop/44.0.2510.1449/win/Opera_44.0.2510.1449_Setup.exe'
  url64          = 'https://get.geo.opera.com/pub/opera/desktop/44.0.2510.1449/win/Opera_44.0.2510.1449_Setup_x64.exe'
  checksum       = '75879cf4e764fb11c97890ab08e0a39b0444e0f6bf68fe4c9f01645a542cef2d'
  checksum64     = 'f3b2df44ea398f278210d9c3809ed0f29fa2e217df3ea7fa16a54d1d2d935b6a'
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
