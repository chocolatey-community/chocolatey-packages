$ErrorActionPreference = 'Stop'
$toolsPath = (Split-Path -Parent $MyInvocation.MyCommand.Definition)
. "$toolsPath\helpers.ps1"

$pp = Get-PackageParameters

$parameters += if ($pp.NoDesktopShortcut) { " /desktopshortcut=0"; Write-Host "Desktop shortcut won't be created" }
$parameters += if ($pp.NoTaskbarShortcut) { " /pintotaskbar=0"; Write-Host "Opera won't be pinned to taskbar" }

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  url            = 'https://get.geo.opera.com/pub/opera/desktop/88.0.4412.74/win/Opera_88.0.4412.74_Setup.exe'
  url64          = 'https://get.geo.opera.com/pub/opera/desktop/88.0.4412.74/win/Opera_88.0.4412.74_Setup_x64.exe'
  checksum       = 'e0e9c586e9bc4b3c4ad681f448e698e08fde0d3d4389d1209a300e02f289b80a'
  checksum64     = '880b8bbcf8ee994767142309e68a111e7556d49987f220983b0204e39f113239'
  checksumType   = 'sha256'
  checksumType64 = 'sha256'
  silentArgs     = '/install /silent /launchopera=0 /setdefaultbrowser=0 /allusers=1' + $parameters
  validExitCodes = @(0)
}

$version = '88.0.4412.74'
if (!$Env:ChocolateyForce -and (IsVersionAlreadyInstalled $version)) {
  Write-Output "Opera $version is already installed. Skipping download and installation."
}
else {
  Install-ChocolateyPackage @packageArgs
}
