$ErrorActionPreference = 'Stop'
$toolsPath = (Split-Path -Parent $MyInvocation.MyCommand.Definition)
. "$toolsPath\helpers.ps1"

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  url            = 'https://get.geo.opera.com/pub/opera/desktop/49.0.2725.56/win/Opera_49.0.2725.56_Setup.exe'
  url64          = 'https://get.geo.opera.com/pub/opera/desktop/49.0.2725.56/win/Opera_49.0.2725.56_Setup_x64.exe'
  checksum       = 'ca0ea93f1035c80975d04c4a953cf58a60bd8d2cd5ceb4e18195197f3dd9214c'
  checksum64     = '52418d472d7d4d8876c568cfc9a52602f501772f598d72803df1ddea166fce1f'
  checksumType   = 'sha256'
  checksumType64 = 'sha256'
  silentArgs     = '/install /silent /launchopera 0 /setdefaultbrowser 0 /desktopshortcut 0 /pintotaskbar 0'
  validExitCodes = @(0)
}

$version = '49.0.2725.56'
if (!$Env:ChocolateyForce -and (IsVersionAlreadyInstalled $version)) {
  Write-Output "Opera $version is already installed. Skipping download and installation."
} else {
  Install-ChocolateyPackage @packageArgs
}
