$ErrorActionPreference = 'Stop'
$toolsPath = (Split-Path -Parent $MyInvocation.MyCommand.Definition)
. "$toolsPath\helpers.ps1"

$pp = Get-PackageParameters

$parameters += if ($pp.NoDesktopShortcut) { " /desktopshortcut=0"; Write-Host "Desktop shortcut won't be created" }
$parameters += if ($pp.NoTaskbarShortcut) { " /pintotaskbar=0"; Write-Host "Opera won't be pinned to taskbar" }

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  url            = 'https://get.geo.opera.com/pub/opera/desktop/67.0.3575.137/win/Opera_67.0.3575.137_Setup.exe'
  url64          = 'https://get.geo.opera.com/pub/opera/desktop/67.0.3575.137/win/Opera_67.0.3575.137_Setup_x64.exe'
  checksum       = '18d6ae2a1d9af7734aa5f99d348f4e9eb89dc25d83dd2ac4417c26582663b48b'
  checksum64     = 'a4d2ca959ddb49eca16fc93032adb2b5bea6e76c3c4228e844a3e1c37137d338'
  checksumType   = 'sha256'
  checksumType64 = 'sha256'
  silentArgs     = '/install /silent /launchopera=0 /setdefaultbrowser=0 /allusers=1' + $parameters
  validExitCodes = @(0)
}

$version = '67.0.3575.137'
if (!$Env:ChocolateyForce -and (IsVersionAlreadyInstalled $version)) {
  Write-Output "Opera $version is already installed. Skipping download and installation."
}
else {
  Install-ChocolateyPackage @packageArgs
}
