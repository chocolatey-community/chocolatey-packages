$ErrorActionPreference = 'Stop'
$toolsPath = (Split-Path -Parent $MyInvocation.MyCommand.Definition)
. "$toolsPath\helpers.ps1"

$pp = Get-PackageParameters

$parameters += if ($pp.NoDesktopShortcut) { " /desktopshortcut=0"; Write-Host "Desktop shortcut won't be created" }
$parameters += if ($pp.NoTaskbarShortcut) { " /pintotaskbar=0"; Write-Host "Opera won't be pinned to taskbar" }

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  url            = 'https://get.geo.opera.com/pub/opera/desktop/94.0.4606.26/win/Opera_94.0.4606.26_Setup.exe'
  url64          = 'https://get.geo.opera.com/pub/opera/desktop/94.0.4606.26/win/Opera_94.0.4606.26_Setup_x64.exe'
  checksum       = 'ec821c8ea16f0261eaafc0299708bd23cd31014b68e365c76ac185621e7278df'
  checksum64     = 'aac97da0c5cea6adca249dbcf52485b16b2f17c6ff385a81d621ce20d1b0b74c'
  checksumType   = 'sha256'
  checksumType64 = 'sha256'
  silentArgs     = '/install /silent /launchopera=0 /setdefaultbrowser=0 /allusers=1' + $parameters
  validExitCodes = @(0)
}

$version = '94.0.4606.26'
if (!$Env:ChocolateyForce -and (IsVersionAlreadyInstalled $version)) {
  Write-Output "Opera $version is already installed. Skipping download and installation."
}
else {
  Install-ChocolateyPackage @packageArgs
}
