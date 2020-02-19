$ErrorActionPreference = 'Stop'
$toolsPath = (Split-Path -Parent $MyInvocation.MyCommand.Definition)
. "$toolsPath\helpers.ps1"

$pp = Get-PackageParameters

$parameters += if ($pp.NoDesktopShortcut) { " /desktopshortcut=0"; Write-Host "Desktop shortcut won't be created" }
$parameters += if ($pp.NoTaskbarShortcut) { " /pintotaskbar=0"; Write-Host "Opera won't be pinned to taskbar" }

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  url            = 'https://get.geo.opera.com/pub/opera/desktop/66.0.3515.103/win/Opera_66.0.3515.103_Setup.exe'
  url64          = 'https://get.geo.opera.com/pub/opera/desktop/66.0.3515.103/win/Opera_66.0.3515.103_Setup_x64.exe'
  checksum       = 'f8cb3e0e3405d709009723dca5daabd2e4985bb0ae0d20d5e4a6a741247ff853'
  checksum64     = '0b2b8ac7551146304e735aa192f2a9bec1c7f976f6908a51a322c352c8568b54'
  checksumType   = 'sha256'
  checksumType64 = 'sha256'
  silentArgs     = '/install /silent /launchopera=0 /setdefaultbrowser=0 /allusers=1' + $parameters
  validExitCodes = @(0)
}

$version = '66.0.3515.103'
if (!$Env:ChocolateyForce -and (IsVersionAlreadyInstalled $version)) {
  Write-Output "Opera $version is already installed. Skipping download and installation."
}
else {
  Install-ChocolateyPackage @packageArgs
}
