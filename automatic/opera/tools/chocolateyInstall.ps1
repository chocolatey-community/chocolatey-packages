$ErrorActionPreference = 'Stop'
$toolsPath = (Split-Path -Parent $MyInvocation.MyCommand.Definition)
. "$toolsPath\helpers.ps1"

$pp = Get-PackageParameters

$parameters += if ($pp.NoDesktopShortcut) { " /desktopshortcut=0"; Write-Host "Desktop shortcut won't be created" }
$parameters += if ($pp.NoTaskbarShortcut) { " /pintotaskbar=0"; Write-Host "Opera won't be pinned to taskbar" }

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  url            = 'https://get.geo.opera.com/pub/opera/desktop/84.0.4316.14/win/Opera_84.0.4316.14_Setup.exe'
  url64          = 'https://get.geo.opera.com/pub/opera/desktop/84.0.4316.14/win/Opera_84.0.4316.14_Setup_x64.exe'
  checksum       = '9b46b37e8c2e551d0796d4b097a72d56b3ae701937a01c13ab802aa62442074d'
  checksum64     = 'e5ef3015312b8dc47b66a3ffbbdbd14ecf736e41b727a898e549f1580aa87ba6'
  checksumType   = 'sha256'
  checksumType64 = 'sha256'
  silentArgs     = '/install /silent /launchopera=0 /setdefaultbrowser=0 /allusers=1' + $parameters
  validExitCodes = @(0)
}

$version = '84.0.4316.14'
if (!$Env:ChocolateyForce -and (IsVersionAlreadyInstalled $version)) {
  Write-Output "Opera $version is already installed. Skipping download and installation."
}
else {
  Install-ChocolateyPackage @packageArgs
}
