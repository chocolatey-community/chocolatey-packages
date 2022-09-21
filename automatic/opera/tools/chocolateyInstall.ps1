$ErrorActionPreference = 'Stop'
$toolsPath = (Split-Path -Parent $MyInvocation.MyCommand.Definition)
. "$toolsPath\helpers.ps1"

$pp = Get-PackageParameters

$parameters += if ($pp.NoDesktopShortcut) { " /desktopshortcut=0"; Write-Host "Desktop shortcut won't be created" }
$parameters += if ($pp.NoTaskbarShortcut) { " /pintotaskbar=0"; Write-Host "Opera won't be pinned to taskbar" }

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  url            = 'https://get.geo.opera.com/pub/opera/desktop/91.0.4516.20/win/Opera_91.0.4516.20_Setup.exe'
  url64          = 'https://get.geo.opera.com/pub/opera/desktop/91.0.4516.20/win/Opera_91.0.4516.20_Setup_x64.exe'
  checksum       = 'df07a66d14c2ecfb166fc4e9087857de2f9f57d76bda37a2dcdd1c95851acaa6'
  checksum64     = 'd5b7524518a7f13e50e67bfd1b260ecadbacb5973bec682f3430f852771aa64a'
  checksumType   = 'sha256'
  checksumType64 = 'sha256'
  silentArgs     = '/install /silent /launchopera=0 /setdefaultbrowser=0 /allusers=1' + $parameters
  validExitCodes = @(0)
}

$version = '91.0.4516.20'
if (!$Env:ChocolateyForce -and (IsVersionAlreadyInstalled $version)) {
  Write-Output "Opera $version is already installed. Skipping download and installation."
}
else {
  Install-ChocolateyPackage @packageArgs
}
