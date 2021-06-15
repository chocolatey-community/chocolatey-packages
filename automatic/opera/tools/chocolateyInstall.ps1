$ErrorActionPreference = 'Stop'
$toolsPath = (Split-Path -Parent $MyInvocation.MyCommand.Definition)
. "$toolsPath\helpers.ps1"

$pp = Get-PackageParameters

$parameters += if ($pp.NoDesktopShortcut) { " /desktopshortcut=0"; Write-Host "Desktop shortcut won't be created" }
$parameters += if ($pp.NoTaskbarShortcut) { " /pintotaskbar=0"; Write-Host "Opera won't be pinned to taskbar" }

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  url            = 'https://get.geo.opera.com/pub/opera/desktop/77.0.4054.80/win/Opera_77.0.4054.80_Setup.exe'
  url64          = 'https://get.geo.opera.com/pub/opera/desktop/77.0.4054.80/win/Opera_77.0.4054.80_Setup_x64.exe'
  checksum       = '5cb902b64eefb8dca44963b4635a76f34b6ecbb7f74b6871d6a6cddc0f31d047'
  checksum64     = '577c3ef2362070feefb429afd4c2d7732e9e507276bd87896036cc9802b3115f'
  checksumType   = 'sha256'
  checksumType64 = 'sha256'
  silentArgs     = '/install /silent /launchopera=0 /setdefaultbrowser=0 /allusers=1' + $parameters
  validExitCodes = @(0)
}

$version = '77.0.4054.80'
if (!$Env:ChocolateyForce -and (IsVersionAlreadyInstalled $version)) {
  Write-Output "Opera $version is already installed. Skipping download and installation."
}
else {
  Install-ChocolateyPackage @packageArgs
}
