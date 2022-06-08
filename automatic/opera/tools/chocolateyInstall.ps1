$ErrorActionPreference = 'Stop'
$toolsPath = (Split-Path -Parent $MyInvocation.MyCommand.Definition)
. "$toolsPath\helpers.ps1"

$pp = Get-PackageParameters

$parameters += if ($pp.NoDesktopShortcut) { " /desktopshortcut=0"; Write-Host "Desktop shortcut won't be created" }
$parameters += if ($pp.NoTaskbarShortcut) { " /pintotaskbar=0"; Write-Host "Opera won't be pinned to taskbar" }

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  url            = 'https://get.geo.opera.com/pub/opera/desktop/88.0.4412.27/win/Opera_88.0.4412.27_Setup.exe'
  url64          = 'https://get.geo.opera.com/pub/opera/desktop/88.0.4412.27/win/Opera_88.0.4412.27_Setup_x64.exe'
  checksum       = 'dbf99ffeed97321982f1bd45d2b0efd0fc53cc4f9d8d9e0da6c724b24fc08761'
  checksum64     = '2ce52a1fda018c8748a234e77a6a8f64306078b547bb3fadabc50d8f59624394'
  checksumType   = 'sha256'
  checksumType64 = 'sha256'
  silentArgs     = '/install /silent /launchopera=0 /setdefaultbrowser=0 /allusers=1' + $parameters
  validExitCodes = @(0)
}

$version = '88.0.4412.27'
if (!$Env:ChocolateyForce -and (IsVersionAlreadyInstalled $version)) {
  Write-Output "Opera $version is already installed. Skipping download and installation."
}
else {
  Install-ChocolateyPackage @packageArgs
}
