$ErrorActionPreference = 'Stop'
$toolsPath = (Split-Path -Parent $MyInvocation.MyCommand.Definition)
. "$toolsPath\helpers.ps1"

$pp = Get-PackageParameters

$parameters += if ($pp.NoDesktopShortcut) { " /desktopshortcut=0"; Write-Host "Desktop shortcut won't be created" }
$parameters += if ($pp.NoTaskbarShortcut) { " /pintotaskbar=0"; Write-Host "Opera won't be pinned to taskbar" }

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  url            = 'https://get.geo.opera.com/pub/opera/desktop/74.0.3911.232/win/Opera_74.0.3911.232_Setup.exe'
  url64          = 'https://get.geo.opera.com/pub/opera/desktop/74.0.3911.232/win/Opera_74.0.3911.232_Setup_x64.exe'
  checksum       = 'd2098e48b6ee9884bdd11f7731d30a2e2d88d2604d63aff2be2989447292fbce'
  checksum64     = '9dc9047ca5174534aa5c803a7b6e306cc31c37dfaab46013afcb777b12b2c67c'
  checksumType   = 'sha256'
  checksumType64 = 'sha256'
  silentArgs     = '/install /silent /launchopera=0 /setdefaultbrowser=0 /allusers=1' + $parameters
  validExitCodes = @(0)
}

$version = '74.0.3911.232'
if (!$Env:ChocolateyForce -and (IsVersionAlreadyInstalled $version)) {
  Write-Output "Opera $version is already installed. Skipping download and installation."
}
else {
  Install-ChocolateyPackage @packageArgs
}
