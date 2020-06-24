$ErrorActionPreference = 'Stop'
$toolsPath = (Split-Path -Parent $MyInvocation.MyCommand.Definition)
. "$toolsPath\helpers.ps1"

$pp = Get-PackageParameters

$parameters += if ($pp.NoDesktopShortcut) { " /desktopshortcut=0"; Write-Host "Desktop shortcut won't be created" }
$parameters += if ($pp.NoTaskbarShortcut) { " /pintotaskbar=0"; Write-Host "Opera won't be pinned to taskbar" }

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  url            = 'https://get.geo.opera.com/pub/opera/desktop/69.0.3686.36/win/Opera_69.0.3686.36_Setup.exe'
  url64          = 'https://get.geo.opera.com/pub/opera/desktop/69.0.3686.36/win/Opera_69.0.3686.36_Setup_x64.exe'
  checksum       = '962cab00cc53368e4eb22db0df93c098780e3a2d8c560ff2b357eafb480c0973'
  checksum64     = '4e739907a96a120ed075cee6105ca709a482f23f40a0e50ece8c8a95fbbb24ed'
  checksumType   = 'sha256'
  checksumType64 = 'sha256'
  silentArgs     = '/install /silent /launchopera=0 /setdefaultbrowser=0 /allusers=1' + $parameters
  validExitCodes = @(0)
}

$version = '69.0.3686.36'
if (!$Env:ChocolateyForce -and (IsVersionAlreadyInstalled $version)) {
  Write-Output "Opera $version is already installed. Skipping download and installation."
}
else {
  Install-ChocolateyPackage @packageArgs
}
