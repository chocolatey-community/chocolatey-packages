$ErrorActionPreference = 'Stop'
$toolsPath = (Split-Path -Parent $MyInvocation.MyCommand.Definition)
. "$toolsPath\helpers.ps1"

$pp = Get-PackageParameters

$parameters += if ($pp.NoDesktopShortcut) { " /desktopshortcut=0"; Write-Host "Desktop shortcut won't be created" }
$parameters += if ($pp.NoTaskbarShortcut) { " /pintotaskbar=0"; Write-Host "Opera won't be pinned to taskbar" }

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  url            = 'https://get.geo.opera.com/pub/opera/desktop/71.0.3770.284/win/Opera_71.0.3770.284_Setup.exe'
  url64          = 'https://get.geo.opera.com/pub/opera/desktop/71.0.3770.284/win/Opera_71.0.3770.284_Setup_x64.exe'
  checksum       = '9445c9277fff4ae4e3ae50e96e8b6e8aec10e2994933f1bdcfb079c7b28c05c8'
  checksum64     = 'ee66d11a76d86c53b8992e58e21424109314b848cc39f27cf3d6e7314ad9f439'
  checksumType   = 'sha256'
  checksumType64 = 'sha256'
  silentArgs     = '/install /silent /launchopera=0 /setdefaultbrowser=0 /allusers=1' + $parameters
  validExitCodes = @(0)
}

$version = '71.0.3770.284'
if (!$Env:ChocolateyForce -and (IsVersionAlreadyInstalled $version)) {
  Write-Output "Opera $version is already installed. Skipping download and installation."
}
else {
  Install-ChocolateyPackage @packageArgs
}
