$ErrorActionPreference = 'Stop'
$toolsPath = (Split-Path -Parent $MyInvocation.MyCommand.Definition)
. "$toolsPath\helpers.ps1"

$pp = Get-PackageParameters

$parameters += if ($pp.NoDesktopShortcut)     { " /desktopshortcut 0"; Write-Host "Desktop shortcut won't be created" }
$parameters += if ($pp.NoTaskbarShortcut)     { " /pintotaskbar 0"; Write-Host "Opera won't be pinned to taskbar" }

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  url            = 'https://get.geo.opera.com/pub/opera/desktop/60.0.3255.27/win/Opera_60.0.3255.27_Setup.exe'
  url64          = 'https://get.geo.opera.com/pub/opera/desktop/60.0.3255.27/win/Opera_60.0.3255.27_Setup_x64.exe'
  checksum       = '83e7b1c4e7147f677a914b7021e0b11c87ff4f6018c6d10e916c2d4f4fa6874d'
  checksum64     = '0e2e44adc062e917284c1dbf0267cb1ae3d6984d34abcf32099f63da7e47cd06'
  checksumType   = 'sha256'
  checksumType64 = 'sha256'
  silentArgs     = '/install /silent /launchopera 0 /setdefaultbrowser 0' + $parameters
  validExitCodes = @(0)
}

$version = '60.0.3255.27'
if (!$Env:ChocolateyForce -and (IsVersionAlreadyInstalled $version)) {
  Write-Output "Opera $version is already installed. Skipping download and installation."
} else {
  Install-ChocolateyPackage @packageArgs
}
