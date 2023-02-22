$ErrorActionPreference = 'Stop'
$toolsPath = (Split-Path -Parent $MyInvocation.MyCommand.Definition)
. "$toolsPath\helpers.ps1"

$pp = Get-PackageParameters

$parameters += if ($pp.NoDesktopShortcut) { " /desktopshortcut=0"; Write-Host "Desktop shortcut won't be created" }
$parameters += if ($pp.NoTaskbarShortcut) { " /pintotaskbar=0"; Write-Host "Opera won't be pinned to taskbar" }

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  url            = 'https://get.geo.opera.com/pub/opera/desktop/96.0.4693.20/win/Opera_96.0.4693.20_Setup.exe'
  url64          = 'https://get.geo.opera.com/pub/opera/desktop/96.0.4693.20/win/Opera_96.0.4693.20_Setup_x64.exe'
  checksum       = 'f802c0938ad733fdb86a05b5be57bb0c4ca75286af06d9c47b22fe9e17d3e56a'
  checksum64     = 'd532a9d9fbb295ddaf369eb5122f7dd22512c2b8dc8921f7eeff08f981e0b5ed'
  checksumType   = 'sha256'
  checksumType64 = 'sha256'
  silentArgs     = '/install /silent /launchopera=0 /setdefaultbrowser=0 /allusers=1' + $parameters
  validExitCodes = @(0)
}

$version = '96.0.4693.20'
if (!$Env:ChocolateyForce -and (IsVersionAlreadyInstalled $version)) {
  Write-Output "Opera $version is already installed. Skipping download and installation."
}
else {
  Install-ChocolateyPackage @packageArgs
}
