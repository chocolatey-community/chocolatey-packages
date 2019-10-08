$ErrorActionPreference = 'Stop'
$toolsPath = (Split-Path -Parent $MyInvocation.MyCommand.Definition)
. "$toolsPath\helpers.ps1"

$pp = Get-PackageParameters

$parameters += if ($pp.NoDesktopShortcut)     { " /desktopshortcut=0"; Write-Host "Desktop shortcut won't be created" }
$parameters += if ($pp.NoTaskbarShortcut)     { " /pintotaskbar=0"; Write-Host "Opera won't be pinned to taskbar" }

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  url            = 'https://get.geo.opera.com/pub/opera/desktop/64.0.3417.47/win/Opera_64.0.3417.47_Setup.exe'
  url64          = 'https://get.geo.opera.com/pub/opera/desktop/64.0.3417.47/win/Opera_64.0.3417.47_Setup_x64.exe'
  checksum       = 'ac0f96bb0b8c3163a6fb551e18bce124d70cc5c0a4044ff503f7158832153416'
  checksum64     = '08d0c0a1057513c78c29c19bb9dc903ac1a2c57fa7a4b1700afc4c07bb753970'
  checksumType   = 'sha256'
  checksumType64 = 'sha256'
  silentArgs     = '/install /silent /launchopera=0 /setdefaultbrowser=0 /allusers=1' + $parameters
  validExitCodes = @(0)
}

$version = '64.0.3417.47'
if (!$Env:ChocolateyForce -and (IsVersionAlreadyInstalled $version)) {
  Write-Output "Opera $version is already installed. Skipping download and installation."
} else {
  Install-ChocolateyPackage @packageArgs
}
