$ErrorActionPreference = 'Stop'
$toolsPath = (Split-Path -Parent $MyInvocation.MyCommand.Definition)
. "$toolsPath\helpers.ps1"

$pp = Get-PackageParameters

$parameters += if ($pp.NoDesktopShortcut) { " /desktopshortcut=0"; Write-Host "Desktop shortcut won't be created" }
$parameters += if ($pp.NoTaskbarShortcut) { " /pintotaskbar=0"; Write-Host "Opera won't be pinned to taskbar" }

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  url            = 'https://get.geo.opera.com/pub/opera/desktop/87.0.4390.36/win/Opera_87.0.4390.36_Setup.exe'
  url64          = 'https://get.geo.opera.com/pub/opera/desktop/87.0.4390.36/win/Opera_87.0.4390.36_Setup_x64.exe'
  checksum       = '6aacf6f4bf93e61c8dde0c0d09bdeb07790c8e8d380d2f788c21c2b94afcfa3a'
  checksum64     = 'fc7d48c33dcfbe3d8d25170a4c62255c3e3d9d51d7316f84943fb2499752158d'
  checksumType   = 'sha256'
  checksumType64 = 'sha256'
  silentArgs     = '/install /silent /launchopera=0 /setdefaultbrowser=0 /allusers=1' + $parameters
  validExitCodes = @(0)
}

$version = '87.0.4390.36'
if (!$Env:ChocolateyForce -and (IsVersionAlreadyInstalled $version)) {
  Write-Output "Opera $version is already installed. Skipping download and installation."
}
else {
  Install-ChocolateyPackage @packageArgs
}
