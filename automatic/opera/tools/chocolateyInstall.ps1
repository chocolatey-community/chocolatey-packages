$ErrorActionPreference = 'Stop'
$toolsPath = (Split-Path -Parent $MyInvocation.MyCommand.Definition)
. "$toolsPath\helpers.ps1"

$pp = Get-PackageParameters

$parameters += if ($pp.NoDesktopShortcut) { " /desktopshortcut=0"; Write-Host "Desktop shortcut won't be created" }
$parameters += if ($pp.NoTaskbarShortcut) { " /pintotaskbar=0"; Write-Host "Opera won't be pinned to taskbar" }

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  url            = 'https://get.geo.opera.com/pub/opera/desktop/75.0.3969.243/win/Opera_75.0.3969.243_Setup.exe'
  url64          = 'https://get.geo.opera.com/pub/opera/desktop/75.0.3969.243/win/Opera_75.0.3969.243_Setup_x64.exe'
  checksum       = 'd3e93ab78289dd9aae3803dd508ecd65ca75b5a368685ba6d3dc95817514a48c'
  checksum64     = '493916beef1d8e3ab45f8e7d70115a8f2138e832baded75c742ab62d21f201e8'
  checksumType   = 'sha256'
  checksumType64 = 'sha256'
  silentArgs     = '/install /silent /launchopera=0 /setdefaultbrowser=0 /allusers=1' + $parameters
  validExitCodes = @(0)
}

$version = '75.0.3969.243'
if (!$Env:ChocolateyForce -and (IsVersionAlreadyInstalled $version)) {
  Write-Output "Opera $version is already installed. Skipping download and installation."
}
else {
  Install-ChocolateyPackage @packageArgs
}
