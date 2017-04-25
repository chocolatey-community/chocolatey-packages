$ErrorActionPreference = 'Stop'
$toolsPath = (Split-Path -Parent $MyInvocation.MyCommand.Definition)
. "$toolsPath\helpers.ps1"

if (Is32BitInstalled) { $env:ChocolateyForceX86 = $true }

$version     = '44.0.2510.857'
$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  url            = 'https://get.geo.opera.com/pub/opera/desktop/44.0.2510.857/win/Opera_44.0.2510.857_Setup.exe'
  url64          = 'https://get.geo.opera.com/pub/opera/desktop/44.0.2510.857/win/Opera_44.0.2510.857_Setup_x64.exe'
  checksum       = '681d5ace1a6029afe8e38b033ab7dd01ad855bb234caeb5017b5c9e1f964ebe1'
  checksum64     = 'd7e8a1c974e134209e05438bdec9409ed4654209ccc7a0a088b25787406ef2cf'
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
