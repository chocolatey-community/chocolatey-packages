$ErrorActionPreference = 'Stop'
$toolsPath = (Split-Path -Parent $MyInvocation.MyCommand.Definition)
. "$toolsPath\helpers.ps1"

$pp = Get-PackageParameters

$parameters += if ($pp.NoDesktopShortcut) { " /desktopshortcut=0"; Write-Host "Desktop shortcut won't be created" }
$parameters += if ($pp.NoTaskbarShortcut) { " /pintotaskbar=0"; Write-Host "Opera won't be pinned to taskbar" }

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  url            = 'https://get.geo.opera.com/pub/opera/desktop/91.0.4516.77/win/Opera_91.0.4516.77_Setup.exe'
  url64          = 'https://get.geo.opera.com/pub/opera/desktop/91.0.4516.77/win/Opera_91.0.4516.77_Setup_x64.exe'
  checksum       = '4b6e0852173f09d8f6c06b35f48efa14f5f31b5178082b4e4e0be391e2914bd9'
  checksum64     = '65b5091aa7e96626a40797474d4359ed28f066fc3e502bb70677f787a1d413b8'
  checksumType   = 'sha256'
  checksumType64 = 'sha256'
  silentArgs     = '/install /silent /launchopera=0 /setdefaultbrowser=0 /allusers=1' + $parameters
  validExitCodes = @(0)
}

$version = '91.0.4516.77'
if (!$Env:ChocolateyForce -and (IsVersionAlreadyInstalled $version)) {
  Write-Output "Opera $version is already installed. Skipping download and installation."
}
else {
  Install-ChocolateyPackage @packageArgs
}
