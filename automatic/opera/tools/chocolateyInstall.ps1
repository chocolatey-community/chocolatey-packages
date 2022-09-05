$ErrorActionPreference = 'Stop'
$toolsPath = (Split-Path -Parent $MyInvocation.MyCommand.Definition)
. "$toolsPath\helpers.ps1"

$pp = Get-PackageParameters

$parameters += if ($pp.NoDesktopShortcut) { " /desktopshortcut=0"; Write-Host "Desktop shortcut won't be created" }
$parameters += if ($pp.NoTaskbarShortcut) { " /pintotaskbar=0"; Write-Host "Opera won't be pinned to taskbar" }

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  url            = 'https://get.geo.opera.com/pub/opera/desktop/90.0.4480.84/win/Opera_90.0.4480.84_Setup.exe'
  url64          = 'https://get.geo.opera.com/pub/opera/desktop/90.0.4480.84/win/Opera_90.0.4480.84_Setup_x64.exe'
  checksum       = '28fc01a31a56481654101fa7a63ce8d978613f5f1ba3d2b5cdd72b91a3ef97eb'
  checksum64     = '450dfaf4b6ac267d973fb66884ae84f5c0df4f43653313758a53702b2cf378fa'
  checksumType   = 'sha256'
  checksumType64 = 'sha256'
  silentArgs     = '/install /silent /launchopera=0 /setdefaultbrowser=0 /allusers=1' + $parameters
  validExitCodes = @(0)
}

$version = '90.0.4480.84'
if (!$Env:ChocolateyForce -and (IsVersionAlreadyInstalled $version)) {
  Write-Output "Opera $version is already installed. Skipping download and installation."
}
else {
  Install-ChocolateyPackage @packageArgs
}
