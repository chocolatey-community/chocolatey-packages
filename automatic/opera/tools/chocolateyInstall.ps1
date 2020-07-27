$ErrorActionPreference = 'Stop'
$toolsPath = (Split-Path -Parent $MyInvocation.MyCommand.Definition)
. "$toolsPath\helpers.ps1"

$pp = Get-PackageParameters

$parameters += if ($pp.NoDesktopShortcut) { " /desktopshortcut=0"; Write-Host "Desktop shortcut won't be created" }
$parameters += if ($pp.NoTaskbarShortcut) { " /pintotaskbar=0"; Write-Host "Opera won't be pinned to taskbar" }

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  url            = 'https://get.geo.opera.com/pub/opera/desktop/69.0.3686.95/win/Opera_69.0.3686.95_Setup.exe'
  url64          = 'https://get.geo.opera.com/pub/opera/desktop/69.0.3686.95/win/Opera_69.0.3686.95_Setup_x64.exe'
  checksum       = 'f584219b3e87729e4565659c73eb47105b17c98213cc181e7f0137e6bd4cce8a'
  checksum64     = '7b56d84cf8226bb5833811eb5f3a446272f4568849308fe76ca08b1b003b7d3d'
  checksumType   = 'sha256'
  checksumType64 = 'sha256'
  silentArgs     = '/install /silent /launchopera=0 /setdefaultbrowser=0 /allusers=1' + $parameters
  validExitCodes = @(0)
}

$version = '69.0.3686.95'
if (!$Env:ChocolateyForce -and (IsVersionAlreadyInstalled $version)) {
  Write-Output "Opera $version is already installed. Skipping download and installation."
}
else {
  Install-ChocolateyPackage @packageArgs
}
