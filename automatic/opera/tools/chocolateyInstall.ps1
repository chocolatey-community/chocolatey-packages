$ErrorActionPreference = 'Stop'
$toolsPath = (Split-Path -Parent $MyInvocation.MyCommand.Definition)
. "$toolsPath\helpers.ps1"

$pp = Get-PackageParameters

$parameters += if ($pp.NoDesktopShortcut) { " /desktopshortcut=0"; Write-Host "Desktop shortcut won't be created" }
$parameters += if ($pp.NoTaskbarShortcut) { " /pintotaskbar=0"; Write-Host "Opera won't be pinned to taskbar" }

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  url            = 'https://get.geo.opera.com/pub/opera/desktop/70.0.3728.154/win/Opera_70.0.3728.154_Setup.exe'
  url64          = 'https://get.geo.opera.com/pub/opera/desktop/70.0.3728.154/win/Opera_70.0.3728.154_Setup_x64.exe'
  checksum       = '5e90e6a01f5dedb5c47dc9ca777e64024b1e5a37c04eacd9b9fb20113024ee3f'
  checksum64     = '4ead9afa64e1e9de5d0b114104a3cfc6ba2565482f83cd9a0217b777815b53fb'
  checksumType   = 'sha256'
  checksumType64 = 'sha256'
  silentArgs     = '/install /silent /launchopera=0 /setdefaultbrowser=0 /allusers=1' + $parameters
  validExitCodes = @(0)
}

$version = '70.0.3728.154'
if (!$Env:ChocolateyForce -and (IsVersionAlreadyInstalled $version)) {
  Write-Output "Opera $version is already installed. Skipping download and installation."
}
else {
  Install-ChocolateyPackage @packageArgs
}
