$ErrorActionPreference = 'Stop'
$toolsPath = (Split-Path -Parent $MyInvocation.MyCommand.Definition)
. "$toolsPath\helpers.ps1"

$pp = Get-PackageParameters

$parameters += if ($pp.NoDesktopShortcut) { " /desktopshortcut=0"; Write-Host "Desktop shortcut won't be created" }
$parameters += if ($pp.NoTaskbarShortcut) { " /pintotaskbar=0"; Write-Host "Opera won't be pinned to taskbar" }

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  url            = 'https://get.geo.opera.com/pub/opera/desktop/81.0.4196.37/win/Opera_81.0.4196.37_Setup.exe'
  url64          = 'https://get.geo.opera.com/pub/opera/desktop/81.0.4196.37/win/Opera_81.0.4196.37_Setup_x64.exe'
  checksum       = '32e1b6c222fee522a9fd71f0dacd8a0cdbf6213353b9612ae8b1151812b941fa'
  checksum64     = '9412a3a44a805e0b5d5b03a685aa1b32cef256f01a8feae93a16bbf38fb348a9'
  checksumType   = 'sha256'
  checksumType64 = 'sha256'
  silentArgs     = '/install /silent /launchopera=0 /setdefaultbrowser=0 /allusers=1' + $parameters
  validExitCodes = @(0)
}

$version = '81.0.4196.37'
if (!$Env:ChocolateyForce -and (IsVersionAlreadyInstalled $version)) {
  Write-Output "Opera $version is already installed. Skipping download and installation."
}
else {
  Install-ChocolateyPackage @packageArgs
}
