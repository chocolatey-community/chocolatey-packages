$ErrorActionPreference = 'Stop'
$toolsPath = (Split-Path -Parent $MyInvocation.MyCommand.Definition)
. "$toolsPath\helpers.ps1"

$pp = Get-PackageParameters

$parameters += if ($pp.NoDesktopShortcut) { " /desktopshortcut=0"; Write-Host "Desktop shortcut won't be created" }
$parameters += if ($pp.NoTaskbarShortcut) { " /pintotaskbar=0"; Write-Host "Opera won't be pinned to taskbar" }

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  url            = 'https://get.geo.opera.com/pub/opera/desktop/90.0.4480.107/win/Opera_90.0.4480.107_Setup.exe'
  url64          = 'https://get.geo.opera.com/pub/opera/desktop/90.0.4480.107/win/Opera_90.0.4480.107_Setup_x64.exe'
  checksum       = '97e8e3e47862a2e7d7ca10cbeb32b0ffa943e767488a13a750dfb5e2edba2b83'
  checksum64     = 'fc8fc2dbe54a1d2707c01de15b2661c201d8eed8f4aa5412024d643e80ebd327'
  checksumType   = 'sha256'
  checksumType64 = 'sha256'
  silentArgs     = '/install /silent /launchopera=0 /setdefaultbrowser=0 /allusers=1' + $parameters
  validExitCodes = @(0)
}

$version = '90.0.4480.107'
if (!$Env:ChocolateyForce -and (IsVersionAlreadyInstalled $version)) {
  Write-Output "Opera $version is already installed. Skipping download and installation."
}
else {
  Install-ChocolateyPackage @packageArgs
}
