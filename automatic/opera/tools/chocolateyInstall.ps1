$ErrorActionPreference = 'Stop'
$toolsPath = (Split-Path -Parent $MyInvocation.MyCommand.Definition)
. "$toolsPath\helpers.ps1"

$pp = Get-PackageParameters

$parameters += if ($pp.NoDesktopShortcut) { " /desktopshortcut=0"; Write-Host "Desktop shortcut won't be created" }
$parameters += if ($pp.NoTaskbarShortcut) { " /pintotaskbar=0"; Write-Host "Opera won't be pinned to taskbar" }

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  url            = 'https://get.geo.opera.com/pub/opera/desktop/87.0.4390.45/win/Opera_87.0.4390.45_Setup.exe'
  url64          = 'https://get.geo.opera.com/pub/opera/desktop/87.0.4390.45/win/Opera_87.0.4390.45_Setup_x64.exe'
  checksum       = 'ea6288246f5be14d41b8177dcabefda18e5c9d0fd7fc436b9ec6d05086299e60'
  checksum64     = '2bf445611d9b43e12cd805b8d8a63b40f28ee3c915f11398e5eb3a8b7c2149c6'
  checksumType   = 'sha256'
  checksumType64 = 'sha256'
  silentArgs     = '/install /silent /launchopera=0 /setdefaultbrowser=0 /allusers=1' + $parameters
  validExitCodes = @(0)
}

$version = '87.0.4390.45'
if (!$Env:ChocolateyForce -and (IsVersionAlreadyInstalled $version)) {
  Write-Output "Opera $version is already installed. Skipping download and installation."
}
else {
  Install-ChocolateyPackage @packageArgs
}
