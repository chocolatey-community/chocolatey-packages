$ErrorActionPreference = 'Stop'
$toolsPath = (Split-Path -Parent $MyInvocation.MyCommand.Definition)
. "$toolsPath\helpers.ps1"

$pp = Get-PackageParameters

$parameters += if ($pp.NoDesktopShortcut) { " /desktopshortcut=0"; Write-Host "Desktop shortcut won't be created" }
$parameters += if ($pp.NoTaskbarShortcut) { " /pintotaskbar=0"; Write-Host "Opera won't be pinned to taskbar" }

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  url            = 'https://get.geo.opera.com/pub/opera/desktop/89.0.4447.51/win/Opera_89.0.4447.51_Setup.exe'
  url64          = 'https://get.geo.opera.com/pub/opera/desktop/89.0.4447.51/win/Opera_89.0.4447.51_Setup_x64.exe'
  checksum       = 'a17595bd76c0e90d1f7e023d8fd2081a8143c975d2959fe373b4dc411699f6c3'
  checksum64     = 'a68b232c017aa235912b4d1dc6e9f571d67af4db782bb6fd1022806bfa1b532d'
  checksumType   = 'sha256'
  checksumType64 = 'sha256'
  silentArgs     = '/install /silent /launchopera=0 /setdefaultbrowser=0 /allusers=1' + $parameters
  validExitCodes = @(0)
}

$version = '89.0.4447.51'
if (!$Env:ChocolateyForce -and (IsVersionAlreadyInstalled $version)) {
  Write-Output "Opera $version is already installed. Skipping download and installation."
}
else {
  Install-ChocolateyPackage @packageArgs
}
