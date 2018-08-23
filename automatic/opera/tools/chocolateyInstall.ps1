$ErrorActionPreference = 'Stop'
$toolsPath = (Split-Path -Parent $MyInvocation.MyCommand.Definition)
. "$toolsPath\helpers.ps1"

$pp = Get-PackageParameters

$parameters += if ($pp.NoDesktopShortcut)     { " /desktopshortcut 0"; Write-Host "Desktop shortcut won't be created" }
$parameters += if ($pp.NoTaskbarShortcut)     { " /pintotaskbar 0"; Write-Host "Opera won't be pinned to taskbar" }

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  url            = 'https://get.geo.opera.com/pub/opera/desktop/55.0.2994.44/win/Opera_55.0.2994.44_Setup.exe'
  url64          = 'https://get.geo.opera.com/pub/opera/desktop/55.0.2994.44/win/Opera_55.0.2994.44_Setup_x64.exe'
  checksum       = 'c58eec77bc1ccb715b96131d09d5bf8e12f3976a144dad2800a40f9557214ac3'
  checksum64     = '2ef0e03978b314104f19871c602e724991ea34ac1eb6fb2f239796c705d033d9'
  checksumType   = 'sha256'
  checksumType64 = 'sha256'
  silentArgs     = '/install /silent /launchopera 0 /setdefaultbrowser 0' + $parameters
  validExitCodes = @(0)
}

$version = '55.0.2994.44'
if (!$Env:ChocolateyForce -and (IsVersionAlreadyInstalled $version)) {
  Write-Output "Opera $version is already installed. Skipping download and installation."
} else {
  Install-ChocolateyPackage @packageArgs
}
