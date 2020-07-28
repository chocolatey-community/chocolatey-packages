$ErrorActionPreference = 'Stop'
$toolsPath = (Split-Path -Parent $MyInvocation.MyCommand.Definition)
. "$toolsPath\helpers.ps1"

$pp = Get-PackageParameters

$parameters += if ($pp.NoDesktopShortcut) { " /desktopshortcut=0"; Write-Host "Desktop shortcut won't be created" }
$parameters += if ($pp.NoTaskbarShortcut) { " /pintotaskbar=0"; Write-Host "Opera won't be pinned to taskbar" }

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  url            = 'https://get.geo.opera.com/pub/opera/desktop/70.0.3728.71/win/Opera_70.0.3728.71_Setup.exe'
  url64          = 'https://get.geo.opera.com/pub/opera/desktop/70.0.3728.71/win/Opera_70.0.3728.71_Setup_x64.exe'
  checksum       = '6fa316c444a8b5d2ba79af874d5b5f5fb76c2e1394f60ab87d740ee656618bf7'
  checksum64     = 'c98fac6e9be38e057e731e10e64a28d827ef98652272e0c45c71cf6406a48296'
  checksumType   = 'sha256'
  checksumType64 = 'sha256'
  silentArgs     = '/install /silent /launchopera=0 /setdefaultbrowser=0 /allusers=1' + $parameters
  validExitCodes = @(0)
}

$version = '70.0.3728.71'
if (!$Env:ChocolateyForce -and (IsVersionAlreadyInstalled $version)) {
  Write-Output "Opera $version is already installed. Skipping download and installation."
}
else {
  Install-ChocolateyPackage @packageArgs
}
