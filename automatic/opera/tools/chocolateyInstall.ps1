$ErrorActionPreference = 'Stop'
$toolsPath = (Split-Path -Parent $MyInvocation.MyCommand.Definition)
. "$toolsPath\helpers.ps1"

$pp = Get-PackageParameters

$parameters += if ($pp.NoDesktopShortcut) { " /desktopshortcut=0"; Write-Host "Desktop shortcut won't be created" }
$parameters += if ($pp.NoTaskbarShortcut) { " /pintotaskbar=0"; Write-Host "Opera won't be pinned to taskbar" }

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  url            = 'https://get.geo.opera.com/pub/opera/desktop/89.0.4447.71/win/Opera_89.0.4447.71_Setup.exe'
  url64          = 'https://get.geo.opera.com/pub/opera/desktop/89.0.4447.71/win/Opera_89.0.4447.71_Setup_x64.exe'
  checksum       = '50031519f41a88b93fad6b0e05ec7e2b2c9c8524c521846434ee4d3e385891d3'
  checksum64     = 'b5ec48cca28ad26d6e561aa0af41e43cb36fdf88dbbd1668918c6a854ea4d1cc'
  checksumType   = 'sha256'
  checksumType64 = 'sha256'
  silentArgs     = '/install /silent /launchopera=0 /setdefaultbrowser=0 /allusers=1' + $parameters
  validExitCodes = @(0)
}

$version = '89.0.4447.71'
if (!$Env:ChocolateyForce -and (IsVersionAlreadyInstalled $version)) {
  Write-Output "Opera $version is already installed. Skipping download and installation."
}
else {
  Install-ChocolateyPackage @packageArgs
}
