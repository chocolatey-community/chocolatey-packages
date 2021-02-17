$ErrorActionPreference = 'Stop'
$toolsPath = (Split-Path -Parent $MyInvocation.MyCommand.Definition)
. "$toolsPath\helpers.ps1"

$pp = Get-PackageParameters

$parameters += if ($pp.NoDesktopShortcut) { " /desktopshortcut=0"; Write-Host "Desktop shortcut won't be created" }
$parameters += if ($pp.NoTaskbarShortcut) { " /pintotaskbar=0"; Write-Host "Opera won't be pinned to taskbar" }

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  url            = 'https://get.geo.opera.com/pub/opera/desktop/74.0.3911.139/win/Opera_74.0.3911.139_Setup.exe'
  url64          = 'https://get.geo.opera.com/pub/opera/desktop/74.0.3911.139/win/Opera_74.0.3911.139_Setup_x64.exe'
  checksum       = '03b91ebb5599ad93e93e9387bf0c4efba47c11fbc13139c55d8a525db610f0a9'
  checksum64     = 'c39ec927aec065190e86f340dbf26e25661034f614d2c7217e6d41ee125fd408'
  checksumType   = 'sha256'
  checksumType64 = 'sha256'
  silentArgs     = '/install /silent /launchopera=0 /setdefaultbrowser=0 /allusers=1' + $parameters
  validExitCodes = @(0)
}

$version = '74.0.3911.139'
if (!$Env:ChocolateyForce -and (IsVersionAlreadyInstalled $version)) {
  Write-Output "Opera $version is already installed. Skipping download and installation."
}
else {
  Install-ChocolateyPackage @packageArgs
}
