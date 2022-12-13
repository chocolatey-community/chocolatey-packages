$ErrorActionPreference = 'Stop'
$toolsPath = (Split-Path -Parent $MyInvocation.MyCommand.Definition)
. "$toolsPath\helpers.ps1"

$pp = Get-PackageParameters

$parameters += if ($pp.NoDesktopShortcut) { " /desktopshortcut=0"; Write-Host "Desktop shortcut won't be created" }
$parameters += if ($pp.NoTaskbarShortcut) { " /pintotaskbar=0"; Write-Host "Opera won't be pinned to taskbar" }

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  url            = 'https://get.geo.opera.com/pub/opera/desktop/93.0.4585.64/win/Opera_93.0.4585.64_Setup.exe'
  url64          = 'https://get.geo.opera.com/pub/opera/desktop/93.0.4585.64/win/Opera_93.0.4585.64_Setup_x64.exe'
  checksum       = 'b4df97ade1df1ecec711f6233a7216bb464097f2858403ff8b5a97613f639f0d'
  checksum64     = '292b40c11ab89b9fe92ee8eba4cabac818b9603cde8912f541fff17efba9f5b9'
  checksumType   = 'sha256'
  checksumType64 = 'sha256'
  silentArgs     = '/install /silent /launchopera=0 /setdefaultbrowser=0 /allusers=1' + $parameters
  validExitCodes = @(0)
}

$version = '93.0.4585.64'
if (!$Env:ChocolateyForce -and (IsVersionAlreadyInstalled $version)) {
  Write-Output "Opera $version is already installed. Skipping download and installation."
}
else {
  Install-ChocolateyPackage @packageArgs
}
