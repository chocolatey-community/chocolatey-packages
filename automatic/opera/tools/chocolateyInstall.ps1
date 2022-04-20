$ErrorActionPreference = 'Stop'
$toolsPath = (Split-Path -Parent $MyInvocation.MyCommand.Definition)
. "$toolsPath\helpers.ps1"

$pp = Get-PackageParameters

$parameters += if ($pp.NoDesktopShortcut) { " /desktopshortcut=0"; Write-Host "Desktop shortcut won't be created" }
$parameters += if ($pp.NoTaskbarShortcut) { " /pintotaskbar=0"; Write-Host "Opera won't be pinned to taskbar" }

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  url            = 'https://get.geo.opera.com/pub/opera/desktop/86.0.4363.23/win/Opera_86.0.4363.23_Setup.exe'
  url64          = 'https://get.geo.opera.com/pub/opera/desktop/86.0.4363.23/win/Opera_86.0.4363.23_Setup_x64.exe'
  checksum       = 'b760837344ec9e1bfe3bcb4cb55cea896d39499f75a434c1b5ea15f7d4afe6b8'
  checksum64     = '40e20336d9dff2216693dcea387ffb9e3f7254e07c2d3a48c0c287ebe6fb3bbc'
  checksumType   = 'sha256'
  checksumType64 = 'sha256'
  silentArgs     = '/install /silent /launchopera=0 /setdefaultbrowser=0 /allusers=1' + $parameters
  validExitCodes = @(0)
}

$version = '86.0.4363.23'
if (!$Env:ChocolateyForce -and (IsVersionAlreadyInstalled $version)) {
  Write-Output "Opera $version is already installed. Skipping download and installation."
}
else {
  Install-ChocolateyPackage @packageArgs
}
