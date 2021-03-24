$ErrorActionPreference = 'Stop'
$toolsPath = (Split-Path -Parent $MyInvocation.MyCommand.Definition)
. "$toolsPath\helpers.ps1"

$pp = Get-PackageParameters

$parameters += if ($pp.NoDesktopShortcut) { " /desktopshortcut=0"; Write-Host "Desktop shortcut won't be created" }
$parameters += if ($pp.NoTaskbarShortcut) { " /pintotaskbar=0"; Write-Host "Opera won't be pinned to taskbar" }

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  url            = 'https://get.geo.opera.com/pub/opera/desktop/75.0.3969.93/win/Opera_75.0.3969.93_Setup.exe'
  url64          = 'https://get.geo.opera.com/pub/opera/desktop/75.0.3969.93/win/Opera_75.0.3969.93_Setup_x64.exe'
  checksum       = '39cb449d4df5cf731eb5681e7921f29f3300df7580ef09026b577183e58acb7e'
  checksum64     = '06639051c097a41c6166a32f1d3a862bb06d36c129bb029dd9d7550445a3ba72'
  checksumType   = 'sha256'
  checksumType64 = 'sha256'
  silentArgs     = '/install /silent /launchopera=0 /setdefaultbrowser=0 /allusers=1' + $parameters
  validExitCodes = @(0)
}

$version = '75.0.3969.93'
if (!$Env:ChocolateyForce -and (IsVersionAlreadyInstalled $version)) {
  Write-Output "Opera $version is already installed. Skipping download and installation."
}
else {
  Install-ChocolateyPackage @packageArgs
}
