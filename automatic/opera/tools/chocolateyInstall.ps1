$ErrorActionPreference = 'Stop'
$toolsPath = (Split-Path -Parent $MyInvocation.MyCommand.Definition)
. "$toolsPath\helpers.ps1"

$pp = Get-PackageParameters

$parameters += if ($pp.NoDesktopShortcut) { " /desktopshortcut=0"; Write-Host "Desktop shortcut won't be created" }
$parameters += if ($pp.NoTaskbarShortcut) { " /pintotaskbar=0"; Write-Host "Opera won't be pinned to taskbar" }

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  url            = 'https://get.geo.opera.com/pub/opera/desktop/71.0.3770.148/win/Opera_71.0.3770.148_Setup.exe'
  url64          = 'https://get.geo.opera.com/pub/opera/desktop/71.0.3770.148/win/Opera_71.0.3770.148_Setup_x64.exe'
  checksum       = 'e2a1f4354e4303af93b2c424030c878d4bb13ee1701c8b9bf59bf0702d0d9900'
  checksum64     = 'aaa8d232a3ff0290dd4c2cab1f68f386f17f0d45b60db25d2d07e5ea4a7383a6'
  checksumType   = 'sha256'
  checksumType64 = 'sha256'
  silentArgs     = '/install /silent /launchopera=0 /setdefaultbrowser=0 /allusers=1' + $parameters
  validExitCodes = @(0)
}

$version = '71.0.3770.148'
if (!$Env:ChocolateyForce -and (IsVersionAlreadyInstalled $version)) {
  Write-Output "Opera $version is already installed. Skipping download and installation."
}
else {
  Install-ChocolateyPackage @packageArgs
}
