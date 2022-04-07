$ErrorActionPreference = 'Stop'
$toolsPath = (Split-Path -Parent $MyInvocation.MyCommand.Definition)
. "$toolsPath\helpers.ps1"

$pp = Get-PackageParameters

$parameters += if ($pp.NoDesktopShortcut) { " /desktopshortcut=0"; Write-Host "Desktop shortcut won't be created" }
$parameters += if ($pp.NoTaskbarShortcut) { " /pintotaskbar=0"; Write-Host "Opera won't be pinned to taskbar" }

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  url            = 'https://get.geo.opera.com/pub/opera/desktop/85.0.4341.60/win/Opera_85.0.4341.60_Setup.exe'
  url64          = 'https://get.geo.opera.com/pub/opera/desktop/85.0.4341.60/win/Opera_85.0.4341.60_Setup_x64.exe'
  checksum       = 'd7e932ea701c7e9418e4195a7e64c420fd931f895ed56a48018617f8009c657d'
  checksum64     = '5e0b636a5c5d83b70bc738be361aa610b943a337dc5f26d095d6e2f51f6229c2'
  checksumType   = 'sha256'
  checksumType64 = 'sha256'
  silentArgs     = '/install /silent /launchopera=0 /setdefaultbrowser=0 /allusers=1' + $parameters
  validExitCodes = @(0)
}

$version = '85.0.4341.60'
if (!$Env:ChocolateyForce -and (IsVersionAlreadyInstalled $version)) {
  Write-Output "Opera $version is already installed. Skipping download and installation."
}
else {
  Install-ChocolateyPackage @packageArgs
}
