$ErrorActionPreference = 'Stop'
$toolsPath = (Split-Path -Parent $MyInvocation.MyCommand.Definition)
. "$toolsPath\helpers.ps1"

$pp = Get-PackageParameters

$parameters += if ($pp.NoDesktopShortcut) { " /desktopshortcut=0"; Write-Host "Desktop shortcut won't be created" }
$parameters += if ($pp.NoTaskbarShortcut) { " /pintotaskbar=0"; Write-Host "Opera won't be pinned to taskbar" }

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  url            = 'https://get.geo.opera.com/pub/opera/desktop/99.0.4788.65/win/Opera_99.0.4788.65_Setup.exe'
  url64          = 'https://get.geo.opera.com/pub/opera/desktop/99.0.4788.65/win/Opera_99.0.4788.65_Setup_x64.exe'
  checksum       = 'df35f62dc46dd9e4c890192754d7333da80de9c05dd2b1adfedf1f7c59b038e4'
  checksum64     = 'a9963c6c7dbc9075c44e52615208de7b494615a15057780b9c9e9d30f025c84f'
  checksumType   = 'sha256'
  checksumType64 = 'sha256'
  silentArgs     = '/install /silent /launchopera=0 /setdefaultbrowser=0 /allusers=1' + $parameters
  validExitCodes = @(0)
}

$version = '99.0.4788.65'
if (!$Env:ChocolateyForce -and (IsVersionAlreadyInstalled $version)) {
  Write-Output "Opera $version is already installed. Skipping download and installation."
}
else {
  Install-ChocolateyPackage @packageArgs
}
