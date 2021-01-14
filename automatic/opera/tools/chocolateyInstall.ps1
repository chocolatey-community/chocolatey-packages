$ErrorActionPreference = 'Stop'
$toolsPath = (Split-Path -Parent $MyInvocation.MyCommand.Definition)
. "$toolsPath\helpers.ps1"

$pp = Get-PackageParameters

$parameters += if ($pp.NoDesktopShortcut) { " /desktopshortcut=0"; Write-Host "Desktop shortcut won't be created" }
$parameters += if ($pp.NoTaskbarShortcut) { " /pintotaskbar=0"; Write-Host "Opera won't be pinned to taskbar" }

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  url            = 'https://get.geo.opera.com/pub/opera/desktop/73.0.3856.344/win/Opera_73.0.3856.344_Setup.exe'
  url64          = 'https://get.geo.opera.com/pub/opera/desktop/73.0.3856.344/win/Opera_73.0.3856.344_Setup_x64.exe'
  checksum       = '14e20585ad04b285e24fec91c941b1c324ff25adcf5c35b8810a666de4ef84e9'
  checksum64     = '24e4085fbf9ddf930759df48954e6d23348a04c7dd568b7549b3eb9471964533'
  checksumType   = 'sha256'
  checksumType64 = 'sha256'
  silentArgs     = '/install /silent /launchopera=0 /setdefaultbrowser=0 /allusers=1' + $parameters
  validExitCodes = @(0)
}

$version = '73.0.3856.344'
if (!$Env:ChocolateyForce -and (IsVersionAlreadyInstalled $version)) {
  Write-Output "Opera $version is already installed. Skipping download and installation."
}
else {
  Install-ChocolateyPackage @packageArgs
}
