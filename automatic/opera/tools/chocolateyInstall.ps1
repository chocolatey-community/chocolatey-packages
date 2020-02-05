$ErrorActionPreference = 'Stop'
$toolsPath = (Split-Path -Parent $MyInvocation.MyCommand.Definition)
. "$toolsPath\helpers.ps1"

$pp = Get-PackageParameters

$parameters += if ($pp.NoDesktopShortcut) { " /desktopshortcut=0"; Write-Host "Desktop shortcut won't be created" }
$parameters += if ($pp.NoTaskbarShortcut) { " /pintotaskbar=0"; Write-Host "Opera won't be pinned to taskbar" }

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  url            = 'https://get.geo.opera.com/pub/opera/desktop/66.0.3515.72/win/Opera_66.0.3515.72_Setup.exe'
  url64          = 'https://get.geo.opera.com/pub/opera/desktop/66.0.3515.72/win/Opera_66.0.3515.72_Setup_x64.exe'
  checksum       = '318d5ffecd08eaee0fedb014d6e0c28f0b0be7469ef950b909c8e6d616c8310f'
  checksum64     = '99636fe69a5dc1232eac0c7dd8f3a8b2fdef61956315d1d8514fcdf67f6b41fd'
  checksumType   = 'sha256'
  checksumType64 = 'sha256'
  silentArgs     = '/install /silent /launchopera=0 /setdefaultbrowser=0 /allusers=1' + $parameters
  validExitCodes = @(0)
}

$version = '66.0.3515.72'
if (!$Env:ChocolateyForce -and (IsVersionAlreadyInstalled $version)) {
  Write-Output "Opera $version is already installed. Skipping download and installation."
}
else {
  Install-ChocolateyPackage @packageArgs
}
