$ErrorActionPreference = 'Stop'
$toolsPath = (Split-Path -Parent $MyInvocation.MyCommand.Definition)
. "$toolsPath\helpers.ps1"

$pp = Get-PackageParameters

$parameters += if ($pp.NoDesktopShortcut) { " /desktopshortcut=0"; Write-Host "Desktop shortcut won't be created" }
$parameters += if ($pp.NoTaskbarShortcut) { " /pintotaskbar=0"; Write-Host "Opera won't be pinned to taskbar" }

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  url            = 'https://get.geo.opera.com/pub/opera/desktop/68.0.3618.46/win/Opera_68.0.3618.46_Setup.exe'
  url64          = 'https://get.geo.opera.com/pub/opera/desktop/68.0.3618.46/win/Opera_68.0.3618.46_Setup_x64.exe'
  checksum       = 'f5a4767c75b56b2a59641568f9e4c2e8554f68b16500313de23429077d765c19'
  checksum64     = '92975c75a969d144acbd02a3fd4707c1f01b1c07347e76ed2fffa564b3dbfc3c'
  checksumType   = 'sha256'
  checksumType64 = 'sha256'
  silentArgs     = '/install /silent /launchopera=0 /setdefaultbrowser=0 /allusers=1' + $parameters
  validExitCodes = @(0)
}

$version = '68.0.3618.46'
if (!$Env:ChocolateyForce -and (IsVersionAlreadyInstalled $version)) {
  Write-Output "Opera $version is already installed. Skipping download and installation."
}
else {
  Install-ChocolateyPackage @packageArgs
}
