$ErrorActionPreference = 'Stop'
$toolsPath = (Split-Path -Parent $MyInvocation.MyCommand.Definition)
. "$toolsPath\helpers.ps1"

$pp = Get-PackageParameters

$parameters += if ($pp.NoDesktopShortcut) { " /desktopshortcut=0"; Write-Host "Desktop shortcut won't be created" }
$parameters += if ($pp.NoTaskbarShortcut) { " /pintotaskbar=0"; Write-Host "Opera won't be pinned to taskbar" }

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  url            = 'https://get.geo.opera.com/pub/opera/desktop/90.0.4480.48/win/Opera_90.0.4480.48_Setup.exe'
  url64          = 'https://get.geo.opera.com/pub/opera/desktop/90.0.4480.48/win/Opera_90.0.4480.48_Setup_x64.exe'
  checksum       = '6150506265f9edd2cb8b5c737c11ab3dbc7ca08409f21dd6803fb6735ef1ab12'
  checksum64     = 'fba897205e9e2e3f5523e82aece5427b25da41523fa701d8101153f99f8e3268'
  checksumType   = 'sha256'
  checksumType64 = 'sha256'
  silentArgs     = '/install /silent /launchopera=0 /setdefaultbrowser=0 /allusers=1' + $parameters
  validExitCodes = @(0)
}

$version = '90.0.4480.48'
if (!$Env:ChocolateyForce -and (IsVersionAlreadyInstalled $version)) {
  Write-Output "Opera $version is already installed. Skipping download and installation."
}
else {
  Install-ChocolateyPackage @packageArgs
}
