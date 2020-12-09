$ErrorActionPreference = 'Stop'
$toolsPath = (Split-Path -Parent $MyInvocation.MyCommand.Definition)
. "$toolsPath\helpers.ps1"

$pp = Get-PackageParameters

$parameters += if ($pp.NoDesktopShortcut) { " /desktopshortcut=0"; Write-Host "Desktop shortcut won't be created" }
$parameters += if ($pp.NoTaskbarShortcut) { " /pintotaskbar=0"; Write-Host "Opera won't be pinned to taskbar" }

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  url            = 'https://get.geo.opera.com/pub/opera/desktop/73.0.3856.257/win/Opera_73.0.3856.257_Setup.exe'
  url64          = 'https://get.geo.opera.com/pub/opera/desktop/73.0.3856.257/win/Opera_73.0.3856.257_Setup_x64.exe'
  checksum       = 'c3795f0fbc91f5d8ba6f60082022a7119e210beccb08f5fa9e305851d71fea6c'
  checksum64     = '7a3b82af2f45d70180f6228b236f074a3bbb6741e566338af580e21f6941873f'
  checksumType   = 'sha256'
  checksumType64 = 'sha256'
  silentArgs     = '/install /silent /launchopera=0 /setdefaultbrowser=0 /allusers=1' + $parameters
  validExitCodes = @(0)
}

$version = '73.0.3856.257'
if (!$Env:ChocolateyForce -and (IsVersionAlreadyInstalled $version)) {
  Write-Output "Opera $version is already installed. Skipping download and installation."
}
else {
  Install-ChocolateyPackage @packageArgs
}
