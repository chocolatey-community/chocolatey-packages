$ErrorActionPreference = 'Stop'
$toolsPath = (Split-Path -Parent $MyInvocation.MyCommand.Definition)
. "$toolsPath\helpers.ps1"

$pp = Get-PackageParameters

$parameters += if ($pp.NoDesktopShortcut) { " /desktopshortcut=0"; Write-Host "Desktop shortcut won't be created" }
$parameters += if ($pp.NoTaskbarShortcut) { " /pintotaskbar=0"; Write-Host "Opera won't be pinned to taskbar" }

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  url            = 'https://get.geo.opera.com/pub/opera/desktop/94.0.4606.65/win/Opera_94.0.4606.65_Setup.exe'
  url64          = 'https://get.geo.opera.com/pub/opera/desktop/94.0.4606.65/win/Opera_94.0.4606.65_Setup_x64.exe'
  checksum       = 'd39c3bbe34affff7a449734c5ca01b1765fed730eea0f8135f45b198d8a38a82'
  checksum64     = 'c27f58901f1da53c2b801d91e07d44bc952db45605dc3b72f6cdce774f1dbbd9'
  checksumType   = 'sha256'
  checksumType64 = 'sha256'
  silentArgs     = '/install /silent /launchopera=0 /setdefaultbrowser=0 /allusers=1' + $parameters
  validExitCodes = @(0)
}

$version = '94.0.4606.65'
if (!$Env:ChocolateyForce -and (IsVersionAlreadyInstalled $version)) {
  Write-Output "Opera $version is already installed. Skipping download and installation."
}
else {
  Install-ChocolateyPackage @packageArgs
}
